from fastapi import APIRouter, HTTPException, Depends, Query, Body
from typing import List, Optional, Dict, Any
from pydantic import BaseModel

# Import Phase 1 models and the AI pipeline
from backend.models import MediaItem, Category, AudioTrack, SubtitleTrack
from services.ai_pipeline import AIPipeline

# Create router instance
router = APIRouter(prefix="/api/v2", tags=["Aegis Overlord"])

# Dependency to get pipeline instance (could be a singleton)
async def get_pipeline() -> AIPipeline:
    # In production, this could be a cached instance or use FastAPI's dependency injection
    return AIPipeline()


# ---------- Request/Response Models for endpoints ----------
class StreamResolveRequest(BaseModel):
    content_id: str
    preferred_quality: Optional[str] = "1080p"
    user_age: Optional[int] = 25
    preferred_audio: Optional[str] = "hi-ur"


class StreamResolveResponse(BaseModel):
    stream_url: str
    quality: str
    profile: Dict[str, Any]
    audio_track: AudioTrack
    allowed: bool
    restricted: bool


class SubtitleGenerateRequest(BaseModel):
    content_id: str
    language: Optional[str] = "ur"  # 'ur' for Urdu, 'en' for English, etc.
    segment_count: Optional[int] = 100


class SubtitleGenerateResponse(BaseModel):
    content_id: str
    language: str
    subtitles: List[Dict[str, Any]]
    format_info: Dict[str, str]


class HealthResponse(BaseModel):
    status: str
    timestamp: str
    services: Dict[str, str]
    latency_avg_ms: int
    active_streams: int


# ---------- Endpoints ----------
@router.post("/stream/resolve", response_model=StreamResolveResponse)
async def resolve_stream(
    request: StreamResolveRequest = Body(...),
    pipeline: AIPipeline = Depends(get_pipeline),
):
    """
    Resolves the optimal stream for a given content ID.
    Applies restricted content filter, selects audio track, and chooses quality.
    """
    # 1. Check restricted access
    allowed = await pipeline.filter_restricted(request.content_id, request.user_age)
    if not allowed:
        # If not allowed, we still return a response but mark as blocked
        # Alternatively, we could raise HTTPException(403)
        pass

    # 2. Harvest metadata (to get available audio tracks, etc.)
    metadata = await pipeline.harvest_metadata(request.content_id)

    # 3. Get available audio tracks (mock, or could come from metadata)
    # For demo, we'll create a mock list. In production, we'd fetch from DB.
    mock_audio_tracks = [
        AudioTrack(id="audio-1", name="Hindi/Urdu Dubbed", language_code="hi-ur", is_original=False, is_default=True),
        AudioTrack(id="audio-2", name="Original Language", language_code="original", is_original=True, is_default=False),
        AudioTrack(id="audio-3", name="English Track", language_code="en", is_original=False, is_default=False),
    ]

    # 4. Route audio
    selected_audio = await pipeline.route_audio(
        content_id=request.content_id,
        preferred_language=request.preferred_audio,
        available_tracks=mock_audio_tracks,
    )

    # 5. Switch quality
    quality_result = await pipeline.switch_quality(
        current_stream_url="https://example.com/stream",
        desired_quality=request.preferred_quality,
        content_id=request.content_id,
    )

    # 6. Build response
    return StreamResolveResponse(
        stream_url=quality_result["stream_url"],
        quality=quality_result["quality"],
        profile=quality_result["profile"],
        audio_track=selected_audio,
        allowed=allowed,
        restricted=metadata.get("restricted", False),
    )


@router.post("/subtitles/generate", response_model=SubtitleGenerateResponse)
async def generate_subtitles(
    request: SubtitleGenerateRequest = Body(...),
    pipeline: AIPipeline = Depends(get_pipeline),
):
    """
    Generates AI‑synthesized subtitles for the given content and language.
    Uses Noto Nastaliq formatting for Urdu.
    """
    subtitles = await pipeline.synthesize_subtitles(
        content_id=request.content_id,
        language=request.language,
        segment_count=request.segment_count,
    )

    return SubtitleGenerateResponse(
        content_id=request.content_id,
        language=request.language,
        subtitles=subtitles,
        format_info={
            "font_family": "Noto Nastaliq Urdu" if request.language == "ur" else "sans-serif",
            "direction": "rtl" if request.language == "ur" else "ltr",
        },
    )


@router.get("/categories/full-catalog", response_model=List[Category])
async def get_full_catalog(
    pipeline: AIPipeline = Depends(get_pipeline),
):
    """
    Returns the complete catalog of all categories with all media items.
    This endpoint uses the AI pipeline to fetch the full dataset.
    """
    categories = await pipeline.get_full_catalog()
    return categories


@router.get("/system/health", response_model=HealthResponse)
async def system_health(
    pipeline: AIPipeline = Depends(get_pipeline),
):
    """
    Comprehensive health check of the entire streaming system.
    """
    health = await pipeline.system_health()
    return HealthResponse(**health)
