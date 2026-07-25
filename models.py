from pydantic import BaseModel, Field, HttpUrl
from typing import List, Optional, Dict
from enum import Enum

class StreamQuality(str, Enum):
    AUTO = "auto"
    SD_480P = "480p"
    HD_720P = "720p"
    FHD_1080P = "1080p"
    UHD_4K = "4k"
    HDR_8K = "8k"

class AudioLanguage(str, Enum):
    HINDI_URDU_AI = "hi-ur-ai"
    HINDI_DUBBED = "hi-dub"
    ORIGINAL = "original"
    ENGLISH = "en"
    PUNJABI = "pa"

class SubtitleLanguage(str, Enum):
    URDU_NASTALIQ_AI = "ur-nastaliq"
    URDU_STANDARD = "ur"
    ENGLISH = "en"
    OFF = "off"

class AudioTrack(BaseModel):
    id: str
    name: str
    language_code: AudioLanguage
    is_original: bool = False
    is_default: bool = False
    channels: str = Field("5.1 Surround", description="Audio channels e.g. 7.1 Dolby Atmos")

class SubtitleTrack(BaseModel):
    id: str
    name: str
    language_code: SubtitleLanguage
    is_default: bool = False
    font_family: Optional[str] = "Noto Nastaliq Urdu"
    vtt_url: Optional[str] = None

class StreamSource(BaseModel):
    quality: StreamQuality
    stream_url: str
    bitrate_kbps: int
    codec: str = "H.265/HEVC"

class MediaItem(BaseModel):
    id: str
    title: str
    description: Optional[str] = None
    poster_url: str
    backdrop_url: Optional[str] = None
    release_year: int
    rating: float = Field(0.0, ge=0.0, le=10.0)
    category_id: str
    streams: List[StreamSource] = Field(default_factory=list)
    audio_tracks: List[AudioTrack] = Field(default_factory=list)
    subtitle_tracks: List[SubtitleTrack] = Field(default_factory=list)
    restricted_18_plus: bool = False
    tags: List[str] = Field(default_factory=list)

class Category(BaseModel):
    id: str
    name: str
    description: Optional[str] = None
    icon: Optional[str] = None
    hex_color: str = "#FF0000"
    badge_label: Optional[str] = None
    total_contents: int = 0
    items: List[MediaItem] = Field(default_factory=list)

class HealthStatus(BaseModel):
    status: str
    engine_level: str
    active_connections: int
    cache_hit_rate: str
