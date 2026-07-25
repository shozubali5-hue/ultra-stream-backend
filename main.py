from fastapi import FastAPI, HTTPException, Query
from typing import List, Optional
from models import Category, MediaItem, HealthStatus, ContentGenre, StreamQuality

app = FastAPI(
    title="Quantum Aegis Ultra Engine",
    version="2.0.0",
    description="God-Level Global Media Streaming Backend with Multi-Language, Hindi Dubbing, and 9 AI Subtitles Architecture."
)

# In-Memory Database Simulation (God-Level Initial Data Vault)
# Here we store global contents: Anime, K-Dramas, Turkish, Donghua, Movies, etc.
GLOBAL_MEDIA_VAULT = [
    MediaItem(
        id="item-001",
        title="Jujutsu Kaisen Epic Season",
        original_language="Japanese",
        description="High-action Japanese anime series with supernatural battles.",
        poster_url="https://picsum.photos/seed/anime1/400/600",
        backdrop_url="https://picsum.photos/seed/anime1_back/1200/600",
        release_year=2026,
        rating=9.8,
        genres=[ContentGenre.ANIME_JAPANESE, ContentGenre.ACTION],
        category_id="cat-anime",
        streams=[
            {"quality": StreamQuality.HD_720P, "stream_url": "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4", "bitrate_kbps": 1200, "codec": "H.264/AAC"},
            {"quality": StreamQuality.SD_480P, "stream_url": "https://sample-videos.com/video123/mp4/480/big_buck_bunny_480p_1mb.mp4", "bitrate_kbps": 700, "codec": "H.264/AAC"},
            {"quality": StreamQuality.LOW_360P, "stream_url": "https://sample-videos.com/video123/mp4/360/big_buck_bunny_360p_1mb.mp4", "bitrate_kbps": 400, "codec": "H.264/AAC"}
        ],
        audio_tracks=[
            {"id": "aud-1", "name": "Japanese (Original Native)", "language_code": "original", "is_original": True, "is_default": True},
            {"id": "aud-2", "name": "Hindi Dubbed", "language_code": "hi-dubbed", "is_original": False, "is_default": False}
        ],
        subtitle_tracks=[
            {"id": "sub-1", "name": "Urdu AI Nastaliq Ultra", "language_code": "ur", "is_default": True},
            {"id": "sub-2", "name": "Urdu AI Fast Neural", "language_code": "ur", "is_default": False},
            {"id": "sub-3", "name": "English CC", "language_code": "en", "is_default": False}
        ],
        has_hindi_dubbing=True,
        restricted_18_plus=False,
        tags=["anime", "action", "trending"]
    ),
    MediaItem(
        id="item-002",
        title="Crash Landing on Romance (K-Drama)",
        original_language="Korean",
        description="A top-tier Korean romantic drama series.",
        poster_url="https://picsum.photos/seed/kdrama2/400/600",
        backdrop_url="https://picsum.photos/seed/kdrama2_back/1200/600",
        release_year=2025,
        rating=9.7,
        genres=[ContentGenre.KDRAMA_ROMANCE, ContentGenre.ROMANCE],
        category_id="cat-kdrama",
        streams=[
            {"quality": StreamQuality.HD_720P, "stream_url": "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4", "bitrate_kbps": 1200, "codec": "H.264/AAC"}
        ],
        audio_tracks=[
            {"id": "aud-k1", "name": "Korean (Original Native)", "language_code": "original", "is_original": True, "is_default": True},
            {"id": "aud-k2", "name": "Hindi Dubbed", "language_code": "hi-dubbed", "is_original": False, "is_default": False}
        ],
        subtitle_tracks=[
            {"id": "sub-1", "name": "Urdu AI Nastaliq Ultra", "language_code": "ur", "is_default": True}
        ],
        has_hindi_dubbing=True,
        restricted_18_plus=False,
        tags=["kdrama", "romance"]
    )
]

@app.get("/", response_model=HealthStatus)
def root_health():
    return HealthStatus(
        status="online",
        engine_level="God-Level Quantum Aegis Active",
        active_connections=1420
    )

@app.get("/api/v1/media", response_model=List[MediaItem])
def get_all_media(
    search: Optional[str] = Query(None, description="Search by title"),
    genre: Optional[ContentGenre] = Query(None, description="Filter by genre"),
    year: Optional[int] = Query(None, description="Filter by release year"),
    hindi_dubbed: Optional[bool] = Query(None, description="Filter only Hindi Dubbed contents")
):
    results = GLOBAL_MEDIA_VAULT

    if search:
        results = [m for m in results if search.lower() in m.title.lower()]
    if genre:
        results = [m for m in results if genre in m.genres]
    if year:
        results = [m for m in results if m.release_year == year]
    if hindi_dubbed is not None:
        results = [m for m in results if m.has_hindi_dubbing == hindi_dubbed]

    return results

@app.get("/api/v1/media/{media_id}", response_model=MediaItem)
def get_media_by_id(media_id: str):
    for item in GLOBAL_MEDIA_VAULT:
        if item.id == media_id:
            return item
    raise HTTPException(status_code=404, detail="Media item not found in Quantum Vault.")
                   
