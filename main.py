from fastapi import FastAPI, HTTPException, Query
from typing import List, Optional
from models import Category, MediaItem, HealthStatus, GlobalCategoryID, ContentGenre, StreamQuality

app = FastAPI(
    title="Quantum Aegis Ultra Engine - God Level Phase 1",
    version="3.0.0",
    description="The Ultimate Global Streaming Backend: Multi-Language, Hindi Dubbing, 9 AI Urdu Subtitle Engines, Strict Quality Control, and 9 Global Categories."
)

# --- GOD-LEVEL GLOBAL MEDIA VAULT (Phase 1 Complete) ---
GLOBAL_CATEGORIES_VAULT = [
    Category(
        id=GlobalCategoryID.ANIME_NETWORK,
        name="Japanese Anime",
        description="Japanese anime series and movies with original native audio and Hindi dubbing support.",
        icon="anime_icon",
        hex_color="#FF5733",
        total_contents=1,
        items=[
            MediaItem(
                id="item-anime-001",
                title="Demon Slayer: Kimetsu no Yaiba (Infinity Arc)",
                original_language="Japanese (Native)",
                description="High-action supernatural Japanese anime series featuring pristine original sound and professional Hindi dubbing.",
                poster_url="https://picsum.photos/seed/anime_poster/400/600",
                backdrop_url="https://picsum.photos/seed/anime_back/1200/600",
                release_year=2026,
                genres=[ContentGenre.ANIME, ContentGenre.ACTION],
                category_id=GlobalCategoryID.ANIME_NETWORK,
                streams=[
                    {"quality": StreamQuality.HD_720P, "stream_url": "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4", "bitrate_kbps": 1200, "codec": "H.264/AAC"},
                    {"quality": StreamQuality.SD_480P, "stream_url": "https://sample-videos.com/video123/mp4/480/big_buck_bunny_480p_1mb.mp4", "bitrate_kbps": 700, "codec": "H.264/AAC"},
                    {"quality": StreamQuality.LOW_360P, "stream_url": "https://sample-videos.com/video123/mp4/360/big_buck_bunny_360p_1mb.mp4", "bitrate_kbps": 400, "codec": "H.264/AAC"}
                ],
                audio_tracks=[
                    {"id": "aud-jp-1", "name": "Japanese (Original Native Track)", "language_code": "original", "is_original": True},
                    {"id": "aud-hi-1", "name": "Hindi Dubbed Audio Track", "language_code": "hi-dubbed", "is_original": False}
                ],
                subtitle_tracks=[
                    {"id": "sub-1", "name": "1. Urdu AI Nastaliq Ultra", "language_code": "ur", "is_default": True},
                    {"id": "sub-2", "name": "2. Urdu AI Fast Neural", "language_code": "ur"},
                    {"id": "sub-3", "name": "3. Urdu AI Deep-Speech v2", "language_code": "ur"},
                    {"id": "sub-4", "name": "4. Urdu AI Smart Auto-Translation", "language_code": "ur"},
                    {"id": "sub-5", "name": "5. Urdu AI Low-Bandwidth (Data Saver)", "language_code": "ur"},
                    {"id": "sub-6", "name": "6. Urdu AI High-Precision", "language_code": "ur"},
                    {"id": "sub-7", "name": "7. Urdu AI Live Dialogue Sync", "language_code": "ur"},
                    {"id": "sub-8", "name": "8. Urdu AI Contextual Grammar", "language_code": "ur"},
                    {"id": "sub-9", "name": "9. Urdu AI Multi-Speaker ID", "language_code": "ur"},
                    {"id": "sub-10", "name": "English Standard CC", "language_code": "en"}
                ],
                has_hindi_dubbing=True,
                restricted_18_plus=False,
                tags=["anime", "action", "trending", "hindi-dubbed"]
            )
        ]
    ),
    Category(
        id=GlobalCategoryID.ASIAN_DRAMAS,
        name="Korean & Chinese Dramas (K-Drama / Donghua)",
        description="Korean romantic dramas, Chinese historical series, and 3D Donghua with dual audio and AI subtitles.",
        icon="kdrama_icon",
        hex_color="#33FF57",
        total_contents=0,
        items=[]
    ),
    Category(
        id=GlobalCategoryID.PAKISTANI_VAULT,
        name="Pakistani Content Vault",
        description="Classic PTV dramas, modern Pakistani serials, and Lollywood movies.",
        icon="pak_icon",
        hex_color="#006600",
        total_contents=0,
        items=[]
    ),
    Category(
        id=GlobalCategoryID.PUNJABI_NETWORK,
        name="Punjabi Network",
        description="Lollywood, Indian Punjabi films, and regional stage theater.",
        icon="punjabi_icon",
        hex_color="#FF33CC",
        total_contents=0,
        items=[]
    ),
    Category(
        id=GlobalCategoryID.BOLLYWOOD_OTT,
        name="Bollywood & Global OTT",
        description="Hindi cinema and major international OTT platform releases.",
        icon="bollywood_icon",
        hex_color="#FF9900",
        total_contents=0,
        items=[]
    ),
    Category(
        id=GlobalCategoryID.HOLLYWOOD_VAULT,
        name="Hollywood Cinema Vault",
        description="Hollywood blockbusters, action, thriller, and sci-fi masterpieces.",
        icon="hollywood_icon",
        hex_color="#3357FF",
        total_contents=0,
        items=[]
    ),
    Category(
        id=GlobalCategoryID.DONGHUA_CINEMA,
        name="Chinese 3D Donghua",
        description="Chinese 3D animation and high-octane martial arts/Wuxia series.",
        icon="donghua_icon",
        hex_color="#9900FF",
        total_contents=0,
        items=[]
    ),
    Category(
        id=GlobalCategoryID.SPORTS_WWE,
        name="Live Sports & WWE",
        description="Live cricket, football streaming channels, and WWE pro-wrestling networks.",
        icon="sports_icon",
        hex_color="#FF0000",
        total_contents=0,
        items=[]
    ),
    Category(
        id=GlobalCategoryID.ADULT_SHIELD,
        name="18+ Adult Restricted Shield",
        description="Restricted mature content protected securely with an in-app PIN shield architecture.",
        icon="adult_icon",
        hex_color="#666666",
        total_contents=0,
        items=[]
    )
]

# --- SERVER HEALTH & STATUS ENDPOINT ---
@app.get("/", response_model=HealthStatus)
def server_health():
    return HealthStatus(
        status="online",
        engine="Quantum Aegis Ultra Engine - God Level Phase 1 Fully Active",
        active_connections=1850
    )

# --- GLOBAL CATEGORIES FETCH ENDPOINT ---
@app.get("/api/v1/categories", response_model=List[Category])
def get_all_categories():
    return GLOBAL_CATEGORIES_VAULT

# --- ADVANCED SEARCH & FILTER ENDPOINT ---
@app.get("/api/v1/media/search", response_model=List[MediaItem])
def search_media(
    query: Optional[str] = Query(None, description="Search media by title or tags"),
    genre: Optional[ContentGenre] = Query(None, description="Filter by content genre"),
    year: Optional[int] = Query(None, description="Filter by exact release year"),
    hindi_dubbed: Optional[bool] = Query(None, description="Filter strictly by Hindi dubbed availability")
):
    all_items = []
    for cat in GLOBAL_CATEGORIES_VAULT:
        all_items.extend(cat.items)

    results = all_items
    if query:
        results = [m for m in results if query.lower() in m.title.lower() or any(query.lower() in t.lower() for t in m.tags)]
    if genre:
        results = [m for m in results if genre in m.genres]
    if year:
        results = [m for m in results if m.release_year == year]
    if hindi_dubbed is not None:
        results = [m for m in results if m.has_hindi_dubbing == hindi_dubbed]

    return results
