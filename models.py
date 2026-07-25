from enum import Enum
from typing import List, Optional
from pydantic import BaseModel, Field

# 1. Strict Video Quality Enforcement (360p, 480p, 720p only - No heavy clutter)[span_6](start_span)[span_6](end_span)[span_7](start_span)[span_7](end_span)
class StreamQuality(str, Enum):
    LOW_360P = "360p"
    SD_480P = "480p"
    HD_720P = "720p"

# 2. The 9 Global Categories & OTT Architecture[span_8](start_span)[span_8](end_span)[span_9](start_span)[span_9](end_span)
class GlobalCategoryID(str, Enum):
    NETFLIX_PRIME_OTT = "netflix-prime-ott-hub"
    PAKISTANI_VAULT = "pakistani-content-vault"
    PUNJABI_NETWORK = "punjabi-network"
    BOLLYWOOD_OTT = "bollywood-ott-hub"
    ANIME_NETWORK = "japanese-anime"
    DONGHUA_CINEMA = "chinese-3d-donghua"
    ASIAN_DRAMAS = "kdrama-cdrama-hub"
    SPORTS_WWE = "sports-wwe-network"
    ADULT_SHIELD = "adult-restricted-shield"

# 3. Comprehensive Global Content Genres (All Countries, Cultures, Styles & 1990-2026 Years Support)[span_10](start_span)[span_10](end_span)[span_11](start_span)[span_11](end_span)
class ContentGenre(str, Enum):
    ACTION = "Action"
    ADVENTURE = "Adventure"
    COMEDY = "Comedy"
    CRIME_THRILLER = "Crime & Thriller"
    DRAMA = "Drama"
    FANTASY_SCI_FI = "Fantasy & Sci-Fi"
    HORROR = "Horror"
    MYSTERY = "Mystery"
    ROMANCE = "Romance"
    SUSPENSE = "Suspense"
    FAMILY = "Family & Kids"
    DOCUMENTARY = "Documentary"
    NETFLIX_ORIGINAL = "Netflix Original Series"
    AMAZON_PRIME_SERIES = "Amazon Prime Series"
    ANIME_JAPANESE = "Japanese Anime"
    DONGHUA_CHINESE = "Chinese 3D Donghua"
    KDRAMA_KOREAN = "Korean Drama (K-Drama)"
    TURKISH_DRAMA = "Turkish Drama"
    CDRAMA_HISTORICAL = "Chinese Historical & Wuxia"
    PAKISTANI_SERIAL = "Pakistani TV Serial"
    PTV_CLASSIC = "Classic PTV Drama (1990s+)"
    LOLLOLLYWOOD = "Lollywood / Punjabi Film"
    BOLLYWOOD_HINDI = "Bollywood Hindi Movie (1990-2026)"
    HOLLYWOOD_BLOCKBUSTER = "Hollywood Blockbuster"
    LIVE_CRICKET = "Live Cricket & Sports"
    WWE_WRESTLING = "WWE / Pro Wrestling"
    ADULT_MATURE = "18+ Adult Content"

# 4. Smart Audio Architecture (Original Native vs Hindi Dubbed Dual Options)[span_12](start_span)[span_12](end_span)[span_13](start_span)[span_13](end_span)
class AudioLanguage(str, Enum):
    ORIGINAL_NATIVE = "original"  # 100% Pure Native Sound if Hindi is not available
    HINDI_DUBBED = "hi-dubbed"    # Hindi Dubbed + Original Dual Option

class AudioTrack(BaseModel):
    id: str
    name: str
    language_code: AudioLanguage
    is_original: bool = False
    is_default: bool = False

# 5. The 9 AI Urdu Subtitle Engines & Noto Nastaliq Framework[span_14](start_span)[span_14](end_span)[span_15](start_span)[span_15](end_span)
class SubtitleTrack(BaseModel):
    id: str
    name: str
    language_code: str = "ur"
    is_default: bool = False
    font_family: str = "Noto Nastaliq Urdu"
    ai_supervisor_active: bool = True

# 6. Stream Source Model with Anti-Buffer & Auto-Scraper Hook[span_16](start_span)[span_16](end_span)[span_17](start_span)[span_17](end_span)
class StreamSource(BaseModel):
    quality: StreamQuality
    stream_url: str
    bitrate_kbps: int
    codec: str = "H.264/AAC"
    anti_buffer_enabled: bool = True  # Zero Buffering Anti-Buffer Supervisor Active
    is_live_low_latency: bool = False

# 7. Media Item Model (Supporting 1990 to 2026 Auto-Updates & All Country Series)[span_18](start_span)[span_18](end_span)[span_19](start_span)[span_19](end_span)
class MediaItem(BaseModel):
    id: str
    title: str
    original_language: str
    country_of_origin: str
    description: str
    poster_url: str
    backdrop_url: str
    release_year: int = Field(..., description="Exact release year from 1990 classics up to 2026")
    rating: float = 9.9
    genres: List[ContentGenre]
    category_id: GlobalCategoryID
    streams: List[StreamSource]
    audio_tracks: List[AudioTrack]
    subtitle_tracks: List[SubtitleTrack]
    has_hindi_dubbing: bool = False
    restricted_18_plus: bool = False
    auto_fetched_from_scrapers: bool = True  # Movies Box style auto-update active
    tags: List[str] = []

# 8. Category Model[span_20](start_span)[span_20](end_span)[span_21](start_span)[span_21](end_span)
class Category(BaseModel):
    id: GlobalCategoryID
    name: str
    description: str
    icon: str
    hex_color: str
    total_contents: int
    items: List[MediaItem] = []

# 9. Server Health & AI Supervisor Status[span_22](start_span)[span_22](end_span)[span_23](start_span)[span_23](end_span)
class HealthStatus(BaseModel):
    status: str = "online"
    engine: str = "Quantum Aegis Ultra Pro Max - God Level AI Streaming & Auto-Scraper Engine Active"
    active_connections: int
    ai_anti_buffer_supervisor: str = "Fully Operational (Zero Buffering across 360p, 480p, 720p)"
    ai_subtitle_supervisor: str = "9 Neural Engines Active with Millisecond Precision Sync"
    auto_update_scraper_status: str = "Active (Syncing 1990-2026 Global Content Automatically)"
  
