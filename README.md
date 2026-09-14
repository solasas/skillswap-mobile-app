# SkillSwap (Flutter frontend)

Flutter client for the SkillSwap Spring Boot backend — a community
skill-exchange app (list skills you teach/want to learn, match with
complementary users, request a swap, schedule sessions, rate each other).

## Architecture

- **Networking**: `dio`, with an interceptor (`lib/core/network/dio_client.dart`)
  that attaches the JWT to every request and forces logout on a 401.
- **State management**: Riverpod (`flutter_riverpod`). Repositories are plain
  Dio wrappers (`lib/repositories`); screens read `FutureProvider`s
  (`lib/providers`) and invalidate them after mutations to refetch.
- **Models**: `freezed` + `json_serializable` (`lib/models`). Enums
  (`lib/core/utils/enums.dart`) are hardcoded to match the backend's wire
  strings (e.g. `SkillCategory.tech.wire == 'TECH'`).
- **Auth**: JWT stored in `flutter_secure_storage`
  (`lib/core/storage/secure_storage_service.dart`). There is no refresh-token
  endpoint, so token expiry (default 24h) is handled purely by the 401 hook
  routing back to `/login`.
- **Routing**: `go_router` with a `StatefulShellRoute` for the four bottom-nav
  tabs (Matches, Requests, Sessions, Profile) and a redirect based on
  `authProvider`'s state (`lib/core/router/app_router.dart`).

## Note on `/matches` response shape

The API spec handed to this client didn't document the exact JSON shape of
`GET /matches` / `/matches/mutual` / `/matches/{userId}`. `MatchResult`
(`lib/models/match_result.dart`) parses defensively, trying several likely
field-name variants (`user`/`matchedUser`, `theyTeach`/`canTeachYou`/etc.) and
degrading to empty lists rather than throwing. If the real backend uses
different keys, adjust the `_firstOf` lookups there — nothing else in the app
depends on the raw JSON.

Similarly `RatingSummary.fromJson` (`lib/models/rating.dart`) tries a few
common key names (`averageRating`/`averageStars`/`average`, etc.) for
`GET /users/{userId}/rating-summary`.

## Running

The backend's CORS only allows `localhost:3000`/`8080`, which only matters
for a Flutter *web* build — mobile/desktop builds aren't subject to CORS.

```bash
flutter pub get

# Regenerate model code after changing anything under lib/models
dart run build_runner build --delete-conflicting-outputs

flutter run
```

`ApiConstants.baseUrl` (`lib/core/network/api_constants.dart`) picks a sane
default per platform with no flags needed: `http://10.0.2.2:8080/api` on the
Android emulator (the only target where plain `localhost` doesn't reach the
host machine), `http://localhost:8080/api` everywhere else (iOS simulator,
macOS/Windows/Linux desktop, web). For a physical device on the same
network as the backend, override it explicitly:

```bash
flutter run --dart-define=API_BASE_URL=http://<your-lan-ip>:8080/api
```
