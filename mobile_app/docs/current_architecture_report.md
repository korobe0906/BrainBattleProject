# BrainBattle Mobile App - Current Architecture Report

## 1. Project Structure

Scope: only `mobile_app` analyzed.

```text
mobile_app/
├─ lib/
│  ├─ app.dart
│  ├─ main.dart
│  ├─ core/
│  │  ├─ api_config.dart
│  │  ├─ network/
│  │  ├─ services/
│  │  ├─ theme/
│  │  ├─ user/
│  │  ├─ utils/
│  │  └─ widgets/
│  └─ features/
│     ├─ auth/
│     ├─ battle/
│     ├─ community/
│     ├─ learning/
│     ├─ profile/
│     └─ shortvideo/
├─ test/
│  ├─ learning/
│  ├─ shortvideo/
│  └─ widget_test.dart
├─ assets/
│  ├─ animations/
│  └─ badges/
├─ android/ ios/ linux/ macos/ web/ windows/
├─ analysis_options.yaml
├─ pubspec.yaml
├─ pubspec.lock
└─ README.md
```

Notes:
- Source architecture is concentrated in `lib/` and `test/`.
- `build/` and `.dart_tool/` are generated artifacts.
- Platform folders are mostly Flutter scaffold/runner infrastructure.

## 2. File-by-file Analysis

Layer legend: UI / Controller / Service / Repository / Model / Routing / Theme / Other

### 2.1 Entry, Core, and Shared

- `lib/main.dart` - App entry point, bootstraps `BrainBattleApp`. Layer: Other. Notes: minimal and clean.
- `lib/app.dart` - Central app wiring: `MaterialApp`, global routes, home selection, fallback route. Layer: Routing. Notes: route table is very large and tightly coupled to feature pages.
- `lib/core/api_config.dart` - Central API config values/constants. Layer: Other. Notes: overlaps with `core/network/api_base.dart` patterns.
- `lib/core/network/api_base.dart` - Host/port resolver (`apiBase`, `apiCore`, `apiMessaging`). Layer: Service. Notes: host strategy duplicated in multiple clients.
- `lib/core/network/auth_api.dart` - Legacy HTTP auth client (email/password login). Layer: Service. Notes: duplicates newer auth implementation under `features/auth/data/auth_api.dart`.
- `lib/core/network/dou_api_client.dart` - Dio client for learning service; injects `x-user-id` from `UserSession`. Layer: Service. Notes: no token refresh strategy; uses hardcoded base fallback.
- `lib/core/network/http_client_with_user.dart` - HTTP wrapper adding `x-user-id` from `UserContextService`. Layer: Service. Notes: may diverge from `UserSession` identity source.
- `lib/core/network/user_api.dart` - User profile/follower/following HTTP calls with bearer token. Layer: Service. Notes: assumes token exists; weak error handling.
- `lib/core/services/token_storage.dart` - Secure storage for access/refresh tokens. Layer: Service. Notes: token lifecycle not fully integrated into requests.
- `lib/core/theme/app_theme.dart` - App light/dark theme definitions. Layer: Theme. Notes: solid centralization.
- `lib/core/theme/palette.dart` - Color palette utilities. Layer: Theme. Notes: good reuse point.
- `lib/core/theme/tokens.dart` - Design tokens (spacing/radius/etc.). Layer: Theme. Notes: useful but not consistently used by all features.
- `lib/core/user/user_context_service.dart` - Temporary user-id context service with SharedPreferences fallback. Layer: Service. Notes: can conflict with `UserSession` source of truth.
- `lib/core/user/user_switcher_widget.dart` - Debug/testing widget to swap user IDs quickly. Layer: UI. Notes: debug utility inside production tree.
- `lib/core/utils/json_num.dart` - Numeric JSON parsing helpers. Layer: Other. Notes: low risk utility.
- `lib/core/widgets/bb_button.dart` - Shared styled button component. Layer: UI. Notes: good reuse primitive.
- `lib/core/widgets/bb_card.dart` - Shared card component. Layer: UI. Notes: good reuse primitive.
- `lib/core/widgets/battle_invite_card.dart` - Shared battle invitation card component. Layer: UI. Notes: name overlaps with community widget of same intent.

### 2.2 Auth Feature

- `lib/features/auth/splash/splash_page.dart` - Splash animation + session check, routes to `MainShell` or `StarterPage`. Layer: UI. Notes: actual auth gate depends only on stored userId.
- `lib/features/auth/starter/starter_page.dart` - Onboarding/starter carousel and entry actions to signup/login. Layer: UI. Notes: very UI-heavy page with large embedded components.
- `lib/features/auth/login/login_page.dart` - Login form UI, uses `LoginController`, handles success/error navigation. Layer: UI. Notes: navigates to `MainShell` directly on success.
- `lib/features/auth/login/login_controller.dart` - Login state (`ValueNotifier`s for loading/error/obscure), delegates to repository. Layer: Controller. Notes: clean but minimal abstraction.
- `lib/features/auth/login/login_repository.dart` - Calls `AuthApiService.login`, saves userId into `UserSession`. Layer: Repository. Notes: no token handling despite token storage existing.
- `lib/features/auth/signup/sign_up_page.dart` - Start signup by email and navigate to OTP page. Layer: UI. Notes: uses controller directly, no repository layer.
- `lib/features/auth/signup/signup_controller.dart` - Performs register/start/resend/verify flow via direct `http.post`. Layer: Service. Notes: inconsistent with login repo pattern.
- `lib/features/auth/verify/verify_otp_page.dart` - OTP collection and resend, then moves to complete profile. Layer: UI. Notes: OTP validation mostly client-side.
- `lib/features/auth/complete/complete_profile_page.dart` - Final signup step (display name, password, confirm) submits registration complete. Layer: UI. Notes: after success pops to first route instead of explicit home/auth route.
- `lib/features/auth/forgot/forgot_start_page.dart` - Forgot-password start by email, delegates to controller/repo, goes to OTP page. Layer: UI. Notes: baseUrl passed through route args.
- `lib/features/auth/forgot/forgot_otp_page.dart` - OTP entry for reset flow. Layer: UI. Notes: no resend handling in this page.
- `lib/features/auth/forgot/forgot_new_password_page.dart` - New password submit for reset flow. Layer: UI. Notes: success uses dialog then pop-to-root.
- `lib/features/auth/forgot/forgot_controller.dart` - Reset flow state with `ChangeNotifier`. Layer: Controller. Notes: differs from `ValueNotifier` style used by login.
- `lib/features/auth/forgot/forgot_repository.dart` - Calls `/auth/forgot/start` and `/auth/forgot/verify`. Layer: Repository. Notes: simple and clear.
- `lib/features/auth/data/auth_api.dart` - Dio auth service (`/auth/simple/login`, `/auth/simple/signup`) with base-url detection and interceptor mapping errors. Layer: Service. Notes: parallel to legacy auth client.
- `lib/features/auth/data/models/auth_user.dart` - Auth user DTO. Layer: Model. Notes: generally straightforward mapping.
- `lib/features/auth/data/services/user_session.dart` - Singleton session service storing only userId in SharedPreferences; `isLoggedIn` is userId presence check. Layer: Service. Notes: session validity does not use token expiry.
- `lib/features/auth/data/user_profile.dart` - User profile model. Layer: Model. Notes: separate from profile feature models.
- `lib/features/auth/data/user_repository.dart` - User-profile related repository over `UserApi`. Layer: Repository. Notes: not central in current auth flow.

### 2.3 Profile Feature

- `lib/features/profile/ui/main_shell.dart` - Main app shell with tab navigation across major features. Layer: UI. Notes: effectively app composition root after auth.
- `lib/features/profile/ui/app_shell.dart` - Alternate/deprecated shell kept for compatibility. Layer: UI. Notes: potential navigation confusion.
- `lib/features/profile/data/models/profile_models.dart` - Profile domain/data models. Layer: Model. Notes: overlaps with auth user profile concepts.
- `lib/features/profile/data/repositories/profile_repository.dart` - Profile data access. Layer: Repository. Notes: direct instantiation pattern common.
- `lib/features/profile/presentation/pages/user_profile_page.dart` - User profile screen. Layer: UI. Notes: hardcoded/temporary user identity patterns reported in code comments.
- `lib/features/profile/presentation/pages/learning_profile_page.dart` - Learning stats profile subpage. Layer: UI.
- `lib/features/profile/presentation/pages/battle_profile_page.dart` - Battle stats profile subpage. Layer: UI.
- `lib/features/profile/presentation/widgets/profile_header.dart` - Header widget for profile summary. Layer: UI.
- `lib/features/profile/presentation/widgets/profile_video_grid.dart` - Profile video grid widget. Layer: UI.

### 2.4 Battle Feature

- `lib/features/battle/battle_routes.dart` - Battle route constants. Layer: Routing.
- `lib/features/battle/models/battle_3v3_lobby_state.dart` - 3v3 lobby state model. Layer: Model.
- `lib/features/battle/models/battle_player.dart` - Player model for battle context. Layer: Model.
- `lib/features/battle/models/battle_stage.dart` - Battle stage model. Layer: Model.
- `lib/features/battle/models/battle_team.dart` - Team model. Layer: Model.
- `lib/features/battle/models/leader.dart` - Leaderboard entry model. Layer: Model.
- `lib/features/battle/models/player_slot_data.dart` - Lobby slot model. Layer: Model.
- `lib/features/battle/ui/battle_flow.dart` - Battle feature orchestration/navigation flow. Layer: Controller. Notes: mixes orchestration and UI route transitions.
- `lib/features/battle/ui/battle_shell.dart` - Battle shell screen. Layer: UI.
- `lib/features/battle/ui/battle_1v1_entry_page.dart` - 1v1 entry screen. Layer: UI.
- `lib/features/battle/ui/battle_1v1_matchmaking_page.dart` - 1v1 matchmaking screen. Layer: UI.
- `lib/features/battle/ui/battle_1v1_match_found_page.dart` - 1v1 match found screen. Layer: UI.
- `lib/features/battle/ui/battle_1v1_lobby_page.dart` - 1v1 lobby. Layer: UI.
- `lib/features/battle/ui/battle_3v3_entry_page.dart` - 3v3 entry screen. Layer: UI.
- `lib/features/battle/ui/battle_3v3_matchmaking_page.dart` - 3v3 matchmaking screen. Layer: UI.
- `lib/features/battle/ui/battle_3v3_match_found_page.dart` - 3v3 match found screen. Layer: UI.
- `lib/features/battle/ui/battle_3v3_lobby_page.dart` - 3v3 lobby screen. Layer: UI.
- `lib/features/battle/ui/battle_play_page.dart` - In-battle play screen. Layer: UI.
- `lib/features/battle/ui/battle_queue_page.dart` - Queue screen. Layer: UI.
- `lib/features/battle/ui/battle_result_page.dart` - Result screen. Layer: UI.
- `lib/features/battle/widgets/queue/battle_mode_card.dart` - Mode card UI. Layer: UI.
- `lib/features/battle/widgets/queue/battle_role_chip.dart` - Role chip UI. Layer: UI.
- `lib/features/battle/widgets/queue/battle_room_code_banner.dart` - Room code banner. Layer: UI.
- `lib/features/battle/widgets/queue/battle_team_panel.dart` - Team panel widget. Layer: UI.
- `lib/features/battle/widgets/queue/leaderboard_section.dart` - Leaderboard section. Layer: UI.
- `lib/features/battle/widgets/queue/mode_meta_row.dart` - Mode metadata row. Layer: UI.
- `lib/features/battle/widgets/queue/player_profile_section.dart` - Player profile section. Layer: UI.
- `lib/features/battle/widgets/queue/progress_section.dart` - Progress section. Layer: UI.
- `lib/features/battle/widgets/queue/utility_actions_section.dart` - Utility actions in queue. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/entry/battle_1v1_header.dart` - 1v1 header widget. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/entry/duel_mode_card.dart` - Duel mode card. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/entry/duel_tab_switcher.dart` - Tab switcher. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/entry/match_info_card.dart` - Match info card. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/entry/room_code_input_card.dart` - Room code input card. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/lobby/battle_lobby_header.dart` - 1v1 lobby header. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/lobby/battle_mode_panel.dart` - 1v1 mode panel. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/lobby/lobby_action_button.dart` - Lobby action button. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/lobby/player_slot.dart` - 1v1 player slot UI. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/lobby/room_code_panel.dart` - 1v1 room code panel. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/matchmaking/battle_tip_card.dart` - Tip card. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/matchmaking/matchmaking_header.dart` - Matchmaking header. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/matchmaking/matchmaking_info_panel.dart` - Matchmaking info panel. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/matchmaking/matchmaking_player_card.dart` - Player card during matching. Layer: UI.
- `lib/features/battle/widgets/battle_1v1/matchmaking/matchmaking_search_animation.dart` - Search animation widget. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/entry/battle_3v3_header.dart` - 3v3 header. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/entry/role_card.dart` - Role card UI. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/entry/team_battle_info_card.dart` - Team battle info card. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/entry/team_mode_explanation_card.dart` - Mode explanation card. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/entry/team_preview_section.dart` - Team preview section. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/entry/team_room_code_card.dart` - Team room code card. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/entry/team_slot_avatar.dart` - Team slot avatar. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/entry/team_tabs.dart` - Team tabs. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/lobby/lobby_actions.dart` - 3v3 lobby actions. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/lobby/lobby_header.dart` - 3v3 lobby header. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/lobby/player_slot.dart` - 3v3 player slot UI. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/lobby/role_badge.dart` - Role badge. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/lobby/role_selector.dart` - Role selector. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/lobby/room_code_card.dart` - Room code card. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/lobby/status_indicator.dart` - Status indicator. Layer: UI.
- `lib/features/battle/widgets/battle_3v3/lobby/team_panel.dart` - Team panel in lobby. Layer: UI.

### 2.5 Community Feature

- `lib/features/community/community_routes.dart` - Community route definitions. Layer: Routing.
- `lib/features/community/data/community_api.dart` - Community API adapter/client. Layer: Service.
- `lib/features/community/data/community_di.dart` - Lightweight dependency wiring. Layer: Other.
- `lib/features/community/data/community_repository.dart` - Community data repository. Layer: Repository.
- `lib/features/community/data/models.dart` - Community models. Layer: Model.
- `lib/features/community/ui/community_view.dart` - Main community view/screen. Layer: UI.
- `lib/features/community/ui/battle/battle_queue_page.dart` - Community-side battle queue screen. Layer: UI. Notes: potential overlap with battle feature queue page.
- `lib/features/community/ui/chats/chats_page.dart` - Chat listing screen. Layer: UI.
- `lib/features/community/ui/thread/thread_page.dart` - Thread detail screen. Layer: UI.
- `lib/features/community/ui/clan/new_clan_page.dart` - New clan creation screen. Layer: UI.
- `lib/features/community/ui/shell/community_shell.dart` - Community shell container. Layer: UI.
- `lib/features/community/ui/_helpers/datetime_helper.dart` - Datetime helper. Layer: Other.
- `lib/features/community/ui/_helpers/dm_display_helper.dart` - DM presentation helper. Layer: Other.
- `lib/features/community/ui/_helpers/dm_helper.dart` - DM utility/helper logic. Layer: Other.
- `lib/features/community/widgets/active_now_strip.dart` - Active-now horizontal list. Layer: UI.
- `lib/features/community/widgets/avatar_name.dart` - Avatar+name component. Layer: UI.
- `lib/features/community/widgets/battle_invite_card.dart` - Battle invite card (community variant). Layer: UI. Notes: duplicated concept with core widget.
- `lib/features/community/widgets/card_container.dart` - Generic card container widget. Layer: UI.
- `lib/features/community/widgets/chat_empty_state.dart` - Empty chat state widget. Layer: UI.
- `lib/features/community/widgets/chat_search_field.dart` - Chat search input widget. Layer: UI.
- `lib/features/community/widgets/message_bubble.dart` - Message bubble UI. Layer: UI.
- `lib/features/community/widgets/message_meta_row.dart` - Message metadata row. Layer: UI.
- `lib/features/community/widgets/thread_filter_bar.dart` - Thread filtering controls. Layer: UI.
- `lib/features/community/widgets/thread_header.dart` - Thread header. Layer: UI.
- `lib/features/community/widgets/thread_list_tile.dart` - Thread list tile. Layer: UI.
- `lib/features/community/widgets/top_header.dart` - Top header widget. Layer: UI.
- `lib/features/community/widgets/unread_badge.dart` - Unread badge widget. Layer: UI.

### 2.6 Learning Feature

- `lib/features/learning/learning.dart` - Feature entry/export barrel. Layer: Other.
- `lib/features/learning/learning_routes.dart` - Learning route constants. Layer: Routing.
- `lib/features/learning/core/hearts_service.dart` - Hearts/lives business logic. Layer: Service.
- `lib/features/learning/core/placement_service.dart` - Placement scoring/logic. Layer: Service.
- `lib/features/learning/core/streak_freeze_service.dart` - Streak freeze logic. Layer: Service.
- `lib/features/learning/core/unlock_service.dart` - Unlock progression logic. Layer: Service.
- `lib/features/learning/data/daily_service.dart` - Daily missions/service calls. Layer: Service.
- `lib/features/learning/data/learning_api_client.dart` - Learning API calls wrapper. Layer: Service.
- `lib/features/learning/data/learning_map_repository.dart` - Learning map repository abstraction. Layer: Repository.
- `lib/features/learning/data/learning_repository.dart` - Main learning repository. Layer: Repository.
- `lib/features/learning/data/lesson_model.dart` - Lesson model. Layer: Model.
- `lib/features/learning/data/lesson_service.dart` - Lesson data service. Layer: Service.
- `lib/features/learning/data/unit_model.dart` - Unit model. Layer: Model.
- `lib/features/learning/data/unit_service.dart` - Unit data service. Layer: Service.
- `lib/features/learning/data/mock/mock_data.dart` - Learning mock data set. Layer: Other.
- `lib/features/learning/domain/attempt_result_model.dart` - Attempt result domain model. Layer: Model.
- `lib/features/learning/domain/domain_model.dart` - Domain/category model. Layer: Model.
- `lib/features/learning/domain/exercise_model.dart` - Exercise model. Layer: Model.
- `lib/features/learning/domain/lesson_summary_model.dart` - Lesson summary model. Layer: Model.
- `lib/features/learning/ui/achievements_page.dart` - Achievements page. Layer: UI.
- `lib/features/learning/ui/curriculum_browser_page.dart` - Curriculum browser page. Layer: UI.
- `lib/features/learning/ui/daily_goal_picker_page.dart` - Daily goal picker page. Layer: UI.
- `lib/features/learning/ui/daily_mission_screen.dart` - Daily missions page. Layer: UI.
- `lib/features/learning/ui/domain_selector_bottom_sheet.dart` - Domain selector bottom sheet. Layer: UI.
- `lib/features/learning/ui/exercise_player_page.dart` - Exercise player page. Layer: UI.
- `lib/features/learning/ui/galaxy_map_screen.dart` - Galaxy map page. Layer: UI.
- `lib/features/learning/ui/league_page.dart` - League/leaderboard page. Layer: UI.
- `lib/features/learning/ui/learning_settings_page.dart` - Learning settings page. Layer: UI.
- `lib/features/learning/ui/learning_stats_page.dart` - Learning stats page. Layer: UI.
- `lib/features/learning/ui/lesson_detail_screen.dart` - Lesson detail page. Layer: UI.
- `lib/features/learning/ui/lesson_start_page.dart` - Lesson start page. Layer: UI.
- `lib/features/learning/ui/lesson_summary_page.dart` - Lesson summary page. Layer: UI.
- `lib/features/learning/ui/lessons_sceen.dart` - Main lessons screen. Layer: UI. Notes: filename typo (`sceen`) indicates maintainability issue.
- `lib/features/learning/ui/mistakes_review_page.dart` - Mistakes review page. Layer: UI.
- `lib/features/learning/ui/placement_test_page.dart` - Placement test page. Layer: UI.
- `lib/features/learning/ui/practice_hub_page.dart` - Practice hub page. Layer: UI.
- `lib/features/learning/ui/review_queue_page.dart` - Review queue page. Layer: UI.
- `lib/features/learning/ui/streak_page.dart` - Streak page. Layer: UI.
- `lib/features/learning/ui/unit_completion_page.dart` - Unit completion page. Layer: UI.
- `lib/features/learning/ui/unit_detail_page.dart` - Unit detail page. Layer: UI.
- `lib/features/learning/ui/widgets/bottom_feedback_bar.dart` - Feedback bar widget. Layer: UI.
- `lib/features/learning/ui/widgets/explanation_drawer.dart` - Explanation drawer widget. Layer: UI.
- `lib/features/learning/ui/widgets/hearts_indicator.dart` - Hearts indicator widget. Layer: UI.
- `lib/features/learning/ui/widgets/learning_empty_state.dart` - Empty state widget. Layer: UI.
- `lib/features/learning/ui/widgets/learning_error_state.dart` - Error state widget. Layer: UI.
- `lib/features/learning/ui/widgets/learning_loading_skeleton.dart` - Loading skeleton widget. Layer: UI.
- `lib/features/learning/ui/widgets/out_of_hearts_dialog.dart` - Out-of-hearts dialog widget. Layer: UI.
- `lib/features/learning/ui/widgets/top_progress_header.dart` - Top progress header widget. Layer: UI.
- `lib/features/learning/ui/widgets/exercise_templates/fill_blank_exercise.dart` - Fill-blank exercise template. Layer: UI.
- `lib/features/learning/ui/widgets/exercise_templates/listening_exercise.dart` - Listening exercise template. Layer: UI.
- `lib/features/learning/ui/widgets/exercise_templates/matching_exercise.dart` - Matching exercise template. Layer: UI.
- `lib/features/learning/ui/widgets/exercise_templates/mcq_exercise.dart` - MCQ exercise template. Layer: UI.
- `lib/features/learning/widgets/lesson_card.dart` - Lesson card widget. Layer: UI.
- `lib/features/learning/widgets/orbit_ring.dart` - Orbit ring visual widget. Layer: UI.
- `lib/features/learning/widgets/planet_fx.dart` - Planet effects widget. Layer: UI.
- `lib/features/learning/widgets/progress_circle.dart` - Progress circle widget. Layer: UI.
- `lib/features/learning/widgets/skill_planet.dart` - Skill planet widget. Layer: UI.
- `lib/features/learning/widgets/starfield.dart` - Starfield background widget. Layer: UI.

### 2.7 Shortvideo Feature

- `lib/features/shortvideo/shortvideo.dart` - Shortvideo feature entry/export. Layer: Other.
- `lib/features/shortvideo/shortvideo_routes.dart` - Shortvideo route constants. Layer: Routing.
- `lib/features/shortvideo/core/follow_service.dart` - Follow/unfollow logic. Layer: Service.
- `lib/features/shortvideo/core/hashtag_service.dart` - Hashtag processing/retrieval logic. Layer: Service.
- `lib/features/shortvideo/core/mute_service.dart` - Mute user/content logic. Layer: Service.
- `lib/features/shortvideo/core/save_service.dart` - Save/favorite logic. Layer: Service.
- `lib/features/shortvideo/core/shortvideo_config.dart` - Feature config flags/constants. Layer: Other.
- `lib/features/shortvideo/core/sound_service.dart` - Sound/audio control service. Layer: Service.
- `lib/features/shortvideo/core/video_controller_pool.dart` - Video controller reuse/pool manager. Layer: Service.
- `lib/features/shortvideo/data/comment_model.dart` - Comment model. Layer: Model.
- `lib/features/shortvideo/data/comment_service.dart` - Comment API service. Layer: Service.
- `lib/features/shortvideo/data/discovery_repository.dart` - Discovery/trending repository. Layer: Repository.
- `lib/features/shortvideo/data/local_shorts_store.dart` - Local persistence/store for shortvideo data. Layer: Service.
- `lib/features/shortvideo/data/search_service.dart` - Search service/API calls. Layer: Service.
- `lib/features/shortvideo/data/shorts_repository.dart` - Main shorts repository abstraction and implementation selection. Layer: Repository.
- `lib/features/shortvideo/data/shortvideo_model.dart` - Shortvideo model. Layer: Model.
- `lib/features/shortvideo/data/shortvideo_service.dart` - Shortvideo API service. Layer: Service.
- `lib/features/shortvideo/data/video_post_model.dart` - Video post model. Layer: Model.
- `lib/features/shortvideo/mock/shorts_mock_data.dart` - Mock shortvideo dataset. Layer: Other.
- `lib/features/shortvideo/ui/hashtag_page.dart` - Hashtag page. Layer: UI.
- `lib/features/shortvideo/ui/inbox_page.dart` - Inbox page. Layer: UI.
- `lib/features/shortvideo/ui/moderation_sheet.dart` - Moderation/report bottom sheet. Layer: UI.
- `lib/features/shortvideo/ui/post_page.dart` - Post details page. Layer: UI.
- `lib/features/shortvideo/ui/profile_page.dart` - Shortvideo profile page. Layer: UI.
- `lib/features/shortvideo/ui/search_results_page.dart` - Search results page. Layer: UI.
- `lib/features/shortvideo/ui/short_video_player_page.dart` - Standalone player page. Layer: UI.
- `lib/features/shortvideo/ui/shorts_recorder_page.dart` - Recorder page. Layer: UI.
- `lib/features/shortvideo/ui/shorts_search_page.dart` - Search page. Layer: UI.
- `lib/features/shortvideo/ui/shortvideo_feed_page.dart` - Feed page. Layer: UI.
- `lib/features/shortvideo/ui/shortvideo_shell.dart` - Feature shell with tabs/navigation. Layer: UI.
- `lib/features/shortvideo/ui/sound_page.dart` - Sound page. Layer: UI.
- `lib/features/shortvideo/ui/upload_picker_page.dart` - Upload picker page. Layer: UI.
- `lib/features/shortvideo/ui/video_editor_page.dart` - Video editor page. Layer: UI.
- `lib/features/shortvideo/ui/widgets/empty_state.dart` - Empty state component. Layer: UI.
- `lib/features/shortvideo/ui/widgets/error_state.dart` - Error state component. Layer: UI.
- `lib/features/shortvideo/ui/widgets/loading_skeleton.dart` - Loading skeleton component. Layer: UI.
- `lib/features/shortvideo/widgets/action_buttons.dart` - Action buttons component. Layer: UI.
- `lib/features/shortvideo/widgets/bottom_bar.dart` - Bottom metadata/action bar. Layer: UI.
- `lib/features/shortvideo/widgets/caption_widget.dart` - Caption widget. Layer: UI.
- `lib/features/shortvideo/widgets/comment_sheet.dart` - Comments sheet component. Layer: UI.
- `lib/features/shortvideo/widgets/comment_tile.dart` - Comment tile component. Layer: UI.
- `lib/features/shortvideo/widgets/demo_banner.dart` - Demo banner widget. Layer: UI.
- `lib/features/shortvideo/widgets/right_rail.dart` - Right action rail component. Layer: UI.
- `lib/features/shortvideo/widgets/share_sheet.dart` - Share sheet component. Layer: UI.
- `lib/features/shortvideo/widgets/shortvideo_player.dart` - Embedded shortvideo player widget. Layer: UI.
- `lib/features/shortvideo/widgets/top_tabs.dart` - Top tabs widget. Layer: UI.

### 2.8 Tests

- `test/widget_test.dart` - Default widget smoke test scaffold. Layer: Other.
- `test/learning/test_core_flow.dart` - Learning flow test. Layer: Other.
- `test/learning/test_out_of_hearts.dart` - Hearts depletion behavior test. Layer: Other.
- `test/learning/test_placement_scoring.dart` - Placement scoring logic test. Layer: Other.
- `test/shortvideo/test_create_flow.dart` - Shortvideo create flow test. Layer: Other.
- `test/shortvideo/test_profile_grid_open_player.dart` - Profile grid player open behavior test. Layer: Other.
- `test/shortvideo/test_routes.dart` - Shortvideo routing test. Layer: Other.
- `test/shortvideo/test_search_flow.dart` - Shortvideo search flow test. Layer: Other.
- `test/shortvideo/test_sound_page_use_sound.dart` - Sound page interaction test. Layer: Other.

## 3. Architecture Overview

Current style:
- Mixed architecture (feature-first modular foldering + ad-hoc MVVM/Controller + repository/service mix).
- Not strict Clean Architecture: UI often talks directly to controller/service with local instantiation.
- Routing is centralized in `app.dart` plus feature-specific route constants.

Data flow (typical path):
- UI page -> controller/notifier -> repository/service -> HTTP/Dio client -> backend.
- Session/user identity is read from either `UserSession` or `UserContextService` depending on subsystem.
- Learning API calls often use `DouApiClient` (Dio + interceptor for `x-user-id`).
- Some auth/signup and legacy calls use direct `http` package.

State management approach:
- Native Flutter notifiers (`ValueNotifier`, `ChangeNotifier`) dominate.
- No global state framework (no Riverpod/Bloc/Provider as primary app-wide state container).
- A few singleton services are used as global state holders (`UserSession`, `UserContextService`, local stores).

## 4. Auth Flow Analysis

Observed flow from code:
- App starts at `SplashPage`.
- `SplashPage` checks `UserSession.instance.isLoggedIn()` (non-empty stored userId).
- If logged in: navigate to `MainShell(initialIndex: 2)`.
- Else: navigate to `StarterPage`.
- `StarterPage` -> Login or Signup.

Login flow:
- `LoginPage` -> `LoginController.login(username, password)`.
- `LoginController` -> `LoginRepository.login()`.
- `LoginRepository` -> `AuthApiService.login()`.
- On success: store `user.id` to `UserSession`; navigate to `MainShell`.

Signup flow:
- `SignUpPage` -> `SignUpController.startRegistration(email)`.
- `VerifyOtpPage` collects OTP, optional resend via same controller.
- `CompleteProfilePage` submits final data via `SignUpController.completeRegistration(...)`.
- Success currently pops to root, not a dedicated post-signup authenticated entry route.

Forgot password flow:
- `ForgotStartPage` -> `ForgotController.start()` -> `ForgotRepository.start()` -> `/auth/forgot/start`.
- `ForgotOtpPage` captures OTP.
- `ForgotNewPasswordPage` -> `ForgotController.verify()` -> `ForgotRepository.verify()` -> `/auth/forgot/verify`.

Session handling findings:
- `UserSession` stores only `userId` in SharedPreferences and treats that as login state.
- `TokenStorage` exists but is not the primary gate for session validity in splash/auth routing.
- Two identity sources exist (`UserSession`, `UserContextService`) causing potential mismatch in headers/session behavior.

Inconsistencies/issues:
- Auth client duplication (`core/network/auth_api.dart` vs `features/auth/data/auth_api.dart`).
- Mixed HTTP libraries (`http` and `dio`) with inconsistent error handling/timeouts.
- No visible global token refresh/logout orchestration despite storage support.
- Signup pathway bypasses repository pattern used by login.

## 5. UI/UX & Component Issues

Reusability and consistency:
- Good base components exist in `core/widgets` and theme tokens.
- Many feature pages still define local widgets/styles inline, reducing reuse.
- Similar widgets duplicated across modules (example: battle invite cards in core and community).

Design consistency:
- Color/animation language is generally consistent in auth pages.
- Naming conventions are mostly consistent but contain quality issues (`lessons_sceen.dart` typo).
- Route strategy mixes named routes and direct `MaterialPageRoute` pushes.

Layout/duplication concerns:
- Large monolithic UI pages (especially starter/auth flows) increase maintenance cost.
- Repeated form and OTP cell UI patterns across auth flows without shared component extraction.
- Multiple shell constructs (`MainShell`, `AppShell`, `ShortVideoShell`, `CommunityShell`) create navigation complexity.

## 6. Technical Debt & Risks

- Mixed architecture rules: repository pattern not consistently applied across auth and feature modules.
- Tight coupling: `app.dart` imports many concrete pages directly and owns broad route concerns.
- Session ambiguity: two user identity providers (`UserSession`, `UserContextService`) used by different network clients.
- API client fragmentation: both `http` and `dio`, with duplicated base URL/platform detection and auth logic.
- Missing auth hardening: no clear centralized refresh-token, unauthorized recovery, or logout flow orchestration.
- Weak abstraction boundaries: UI often constructs repos/services directly (limited dependency injection).
- Duplication risks: shared concepts implemented in multiple folders (invite cards, repeated auth widgets).
- Test coverage skew: tests mainly for learning/shortvideo happy paths; low coverage for auth/session/network edge cases.
- Route maintenance risk: very large global route map may become brittle as modules grow.
- Environment risk: hardcoded LAN/IP defaults can break across developer machines and CI/device setups.
