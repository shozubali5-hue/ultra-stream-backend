from fastapi import FastAPI, HTTPException, Query
from fastapi.middleware.cors import CORSMiddleware
from typing import List, Optional
import time

from models import (
    Category, MediaItem, AudioTrack, SubtitleTrack, 
    StreamSource, StreamQuality, AudioLanguage, SubtitleLanguage, HealthStatus
)

app = FastAPI(
    title="⚡ QUANTUM AEGIS ULTRA ENGINE",
    version="2.0.0-PRO",
    description="Next-Gen High-Speed Streaming API Architecture"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def _generate_hyper_audio() -> List[AudioTrack]:
    return [
        AudioTrack(id="a-1", name="Urdu / Hindi AI Neural Dubbed (Dolby 7.1)", language_code=AudioLanguage.HINDI_URDU_AI, is_original=False, is_default=True, channels="7.1 Atmos"),
        AudioTrack(id="a-2", name="Original Mastering Audio", language_code=AudioLanguage.ORIGINAL, is_original=True, is_default=False, channels="5.1 Lossless"),
        AudioTrack(id="a-3", name="English HD Audio Track", language_code=AudioLanguage.ENGLISH, is_original=False, is_default=False, channels="5.1 Surround"),
    ]

def _generate_hyper_subtitles() -> List[SubtitleTrack]:
    return [
        SubtitleTrack(id="s-1", name="Urdu AI Nastaliq (Real-time Render)", language_code=SubtitleLanguage.URDU_NASTALIQ_AI, is_default=True, font_family="Noto Nastaliq Urdu", vtt_url="https://api.stream.internal/subs/ur.vtt"),
        SubtitleTrack(id="s-2", name="English Subtitles (CC)", language_code=SubtitleLanguage.ENGLISH, is_default=False, font_family="Roboto", vtt_url="https://api.stream.internal/subs/en.vtt"),
        SubtitleTrack(id="s-3", name="Subtitles OFF", language_code=SubtitleLanguage.OFF, is_default=False),
    ]

def _generate_streams() -> List[StreamSource]:
    return [
        StreamSource(quality=StreamQuality.UHD_4K, stream_url="https://cdn.quantum-aegis.stream/4k/manifest.m3u8", bitrate_kbps=15000, codec="AV1/HEVC"),
        StreamSource(quality=StreamQuality.FHD_1080P, stream_url="https://cdn.quantum-aegis.stream/1080p/manifest.m3u8", bitrate_kbps=6000, codec="H.265"),
        StreamSource(quality=StreamQuality.HD_720P, stream_url="https://cdn.quantum-aegis.stream/720p/manifest.m3u8", bitrate_kbps=2500, codec="H.264"),
    ]

def _build_quantum_catalog(cat_id: str, count: int, is_18: bool = False) -> List[MediaItem]:
    items = []
    for i in range(1, count + 1):
        items.append(
            MediaItem(
                id=f"{cat_id}-q{i}",
                title=f"{cat_id.capitalize()} Quantum Prime #{i}",
                description=f"Ultra High Definition Quantum Stream #{i} with AI Neural Audio Subsystem.",
                poster_url=f"https://picsum.photos/seed/{cat_id}_{i}/400/600",
                backdrop_url=f"https://picsum.photos/seed/{cat_id}_{i}_bg/1920/1080",
                release_year=2026,
                rating=9.8,
                category_id=cat_id,
                streams=_generate_streams(),
                audio_tracks=_generate_hyper_audio(),
                subtitle_tracks=_generate_hyper_subtitles(),
                restricted_18_plus=is_18,
                tags=["4K Ultra", "Dolby Atmos", "AI Subtitles", "Instant Routing"]
            )
        )
    return items

ADVANCED_CATEGORIES = [
    Category(id="pakistani", name="Pakistani Drama & Cinema Vault", description="4K Ultra Remastered Hits 1990-2026", icon="🇵🇰", hex_color="#10B981", badge_label="🇵🇰 Ultra Original", total_contents=150, items=_build_quantum_catalog("pakistani", 12)),
    Category(id="punjabi", name="Punjabi Blockbuster Network", description="Lollywood & Chardda Punjab Cinema", icon="🎭", hex_color="#F59E0B", badge_label="Desi Ultra Hit", total_contents=95, items=_build_quantum_catalog("punjabi", 8)),
    Category(id="bollywood", name="Bollywood & Global OTT Universal", description="Netflix, Prime, Hotstar & SonyLIV Direct Link", icon="🎬", hex_color="#E11D48", badge_label="OTT Master Engine", total_contents=500, items=_build_quantum_catalog("bollywood", 15)),
    Category(id="hollywood", name="Hollywood Quantum HD Stream Routing", icon="🎥", hex_color="#3B82F6", badge_label="Hollywood 4K", total_contents=420, items=_build_quantum_catalog("hollywood", 10)),
    Category(id="anime", name="Anime Neural Network", description="Japanese Anime with Instant Urdu Subtitles", icon="⛩️", hex_color="#EC4899", badge_label="Anime Ultra", total_contents=310, items=_build_quantum_catalog("anime", 9)),
    Category(id="donghua", name="Donghua 3D Animation Realm", description="Chinese High-Fps Animation Engine", icon="🐉", hex_color="#8B5CF6", badge_label="Chinese 3D Pro", total_contents=180, items=_build_quantum_catalog("donghua", 7)),
    Category(id="asian_dramas", name="Asian Dramas Hub (K-Drama / C-Drama)", icon="🌸", hex_color="#F472B6", badge_label="K-Drama AI Dubbed", total_contents=260, items=_build_quantum_catalog("asian_dramas", 11)),
    Category(id="world_restricted", name="Restricted Adult Lock (18+ Quantum Shield)", icon="🔞", hex_color="#EF4444", badge_label="Strict Child-Lock", total_contents=50, items=_build_quantum_catalog("world_restricted", 5, is_18=True)),
    Category(id="sports", name="Ultra Low-Latency Live Sports", description="Zero-Lag Live Cricket Engine", icon="🏏", hex_color="#84CC16", badge_label="⚡ 0ms Lag Live", total_contents=20, items=_build_quantum_catalog("sports", 6)),
]

@app.get("/")
async def root():
    return {
        "engine": "QUANTUM AEGIS ULTRA ENGINE",
        "status": "Online & Supercharged",
        "timestamp": time.time(),
        "phase": "Quantum Ultra Max"
    }

@app.get("/categories", response_model=List[Category])
async def get_categories(limit: int = Query(10, ge=1, le=50)):
    response = []
    for cat in ADVANCED_CATEGORIES:
        copied = cat.model_copy(update={"items": cat.items[:limit]})
        response.append(copied)
    return response

@app.get("/items/{item_id}", response_model=MediaItem)
async def get_item_by_id(item_id: str):
    for cat in ADVANCED_CATEGORIES:
        for item in cat.items:
            if item.id == item_id:
                return item
    raise HTTPException(status_code=404, detail="Media Content Not Found on Quantum Engine")

@app.get("/health", response_model=HealthStatus)
async def get_health():
    return HealthStatus(
        status="OPERATIONAL",
        engine_level="Quantum Aegis Master Tier",
        active_connections=12500,
        cache_hit_rate="99.4%"
)
  
