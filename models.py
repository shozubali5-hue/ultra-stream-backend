from enum import Enum
from typing import List, Optional
from pydantic import BaseModel, Field

# 1. Strict Video Quality Enforcement (360p, 480p, 720p only)
class StreamQuality(str, Enum):
    AUTO = "auto"
    LOW_360P = "360p"
    SD_480P = "480p"
    HD_720P = "720p"

# 2. Comprehensive Global Content Genres
class ContentGenre(str, Enum):
    ACTION = "Action"
    ADVENTURE = "Adventure"
    ANIME_JAPANESE = "Japanese Anime"
    DONGHUA_3D = "Chinese 3D Donghua"
    KDRAMA_ROMANCE = "Korean Drama"
    TURKISH_DRAMA = "Turkish Drama"
    CDRAMA_HISTORICAL = "Chinese Historical Drama"
    COMEDY = "Comedy"
    CRIME_THRILLER = "Crime & Thriller"
    DRAMA = "Drama"
    FANTASY_SCI_FI = "Fantasy & Sci-Fi"
    HORROR = "Horror"
    MARTIAL_ARTS = "Martial Arts / Wuxia"
    ROMANCE = "Romance"
    SPORTS_LIVE = "Live Sports"
    WWE_WRESTLING = "WWE / Pro Wrestling"
    ADULT_RESTRICTED = "18+ Restricted Lock"

# 3. Audio Tracks (Original Native + Hindi Dubbed + English)
class AudioLanguage(str, Enum):
    ORIGINAL_NATIVE = "original"  # 100% Pure Native Audio (Japanese, Korean, Turkish, Chinese)
    HINDI_DUBBED = "hi-dubbed"    # Hindi Dubbed Track (If available)
    ENGLISH_HD = "en"             # English Audio Track

# 4. Subtitle Track Model (Supporting 9 AI Urdu Engines + English + Off)
class SubtitleTrack(BaseModel):
    id: str
    name: str  # e.g., "Urdu AI Nastaliq Ultra", "Urdu AI Fast Neural", etc.
    language_code: str
    is_default: bool = False
    font_family: str = "Noto Nastaliq Urdu"

# 5. Audio Track Configuration Model
class AudioTrack(BaseModel):
    id: str
    name: str
    language_code: AudioLanguage
    is_original: bool = False
    is_default: bool = False

# 6. Stream Source Model (Zero-Lag Router Ready)
class StreamSource(BaseModel):
    quality: StreamQuality
    stream_url: str
    bitrate_kbps: int
    codec: str = "H.264/AAC"

# 7. Core Media Item Model (Movies, Seasons, Anime, K-Dramas, Turkish, etc.)
class MediaItem(BaseModel):
    id: str = Field(..., description="Unique Global Media ID")
    title: str
    original_language: str = "Japanese / Korean / Turkish / Chinese / English"
    description: str
    poster_url: str
    backdrop_url: str
    release_year: int = Field(..., description="Exact Release Year like 2026, 2025")
    rating: float = 9.9
    genres: List[ContentGenre]
    category_id: str
    streams: List[StreamSource]
    audio_tracks: List[AudioTrack]
    subtitle_tracks: List[SubtitleTrack]
    has_hindi_dubbing: bool = False
    restricted_18_plus: bool = False
    tags: List[str] = []

# 8. Category Vault Model (9 Main Categories)
class Category(BaseModel):
    id: str
    name: str
    description: str = ""
    icon: str
    hex_color: str
    badge_label: str
    total_contents: int
    items: List[MediaItem] = []

# 9. Server Status Model
class HealthStatus(BaseModel):
    status: str = "online"
    engine_level: str = "God-Level Quantum Aegis"
    active_connections: int
    cache_hit_rate: str = "99.8%"
  
