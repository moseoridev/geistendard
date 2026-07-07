# Geistendard

[English](README.md)

> 포크 안내: Geistendard는 [Jetendard](https://github.com/kuskhan/jetendard)를
> 기반으로 한 fork 파생 빌드입니다. Jetendard의 한글/CJK 맞춤 파이프라인을
> 유지하되, 기본 라틴 소스를 Geist Mono로 바꾸고 이 저장소의 빌드/릴리스 선택을
> 더했습니다.

이 브랜치는 터미널과 IDE 사용을 위한 하이브리드 폰트를 빌드합니다. 라틴
글리프는 [Geist Mono](https://github.com/vercel/geist-font/tree/main/fonts/GeistMono),
한글/CJK 글리프는 [Pretendard](https://github.com/orioncactus/pretendard)를
사용하고, 한글 맞춤과 메타데이터 처리는 Jetendard 파이프라인을 유지합니다.

한글/CJK 글리프는 라틴 고정폭의 정확히 두 배 폭에 맞춰집니다. 기본 한글 배율은
`1.10`이며, 기존 Jetendard의 `1.15`보다 터미널에서 덜 과한 중간값입니다.

생성되는 기본 폰트 패밀리 이름은 `Geistendard`입니다. 기본 Geist Mono 소스는
Nerd Font 패치가 적용되어 있지 않으므로, 터미널 심볼은 TTF 빌드 후 `make nerd`로
추가합니다.

## 다운로드

설치 가능한 빌드는
[GitHub Releases](https://github.com/moseoridev/geistendard/releases)에
게시합니다. Geistendard 전용 캡처가 준비되기 전까지 스크린샷은 의도적으로
생략합니다. 이 fork를 잘못 보여 줄 수 있는 기존 Jetendard 시절 스크린샷은
제거했습니다.

## 빌드

```bash
uv sync --all-groups
make download
make run
make nerd
make test
```

`make run`은 이 빌더가 지원하는 Geist Mono upright 굵기를 모두 빌드합니다.
`make nerd`는 생성된 TTF 파일을 `fonts/nerd-font`에 Nerd Font로 패치합니다.
FontForge, `curl`, `unzip`이 필요합니다.

생성된 파일은 다음 위치에 기록됩니다.

- `fonts/ttf/Geistendard-*.ttf`
- `fonts/otf/Geistendard-*.otf`
- `fonts/webfont/Geistendard-*.woff2`
- `fonts/webfont/geistendard.css`
- `make nerd` 실행 후 `fonts/nerd-font/*`

생성 결과물과 업스트림 다운로드 파일은 의도적으로 git에서 무시됩니다.

## CLI

```bash
uv run jetendard --help
```

주요 옵션:

- `--latin-source`: 기본값은 `geist`; 기존 JetBrainsMono Nerd Font Mono 소스는
  `jetbrains-nerd`로 선택 가능
- `--latin-dir`: 라틴 소스 TTF 파일 디렉터리. 기본 경로는 `--latin-source`에 따라 결정
- `--cjk-dir`: `Pretendard-*.ttf`가 들어 있는 디렉터리
- `--all`: 선택한 라틴 소스 프로필이 지원하는 모든 변형 빌드
- `--variants`: `Regular`, `Light`, `Bold`처럼 출력 변형을 명시
- `--weights`: 빌드할 굵기. `--styles`가 없으면 upright 변형을 선택
- `--styles`: `normal`, `italic`, 또는 둘 다. 기본 Geist 소스는 `normal`만 지원
- `--korean-italic-mode`: italic 변형에서 한글/CJK를 처리하는 정책. 현재는 `upright`
- `--korean-scale`: 한글/CJK 글리프 맞춤에 사용할 시각적 배율
- `--scale`: `--korean-scale`의 호환성 별칭

기본 한글 배율은 `1.10`입니다.

예시:

```bash
uv run jetendard --all
uv run jetendard --variants Regular Light Bold
uv run jetendard --latin-source jetbrains-nerd --weights Regular Bold --styles normal italic
```

## 변형 지원 범위

기본 `geist` 프로필은 upright 변형만 빌드합니다.

| 굵기 | Upright | Pretendard 한글/CJK 소스 |
| --- | --- | --- |
| Thin | `Geistendard-Thin` | `Pretendard-Thin` |
| ExtraLight | `Geistendard-ExtraLight` | `Pretendard-ExtraLight` |
| Light | `Geistendard-Light` | `Pretendard-Light` |
| Regular | `Geistendard-Regular` | `Pretendard-Regular` |
| Medium | `Geistendard-Medium` | `Pretendard-Medium` |
| SemiBold | `Geistendard-SemiBold` | `Pretendard-SemiBold` |
| Bold | `Geistendard-Bold` | `Pretendard-Bold` |
| ExtraBold | `Geistendard-ExtraBold` | `Pretendard-ExtraBold` |

선택적 `jetbrains-nerd` 프로필은 기존 JetBrainsMono Nerd Font Mono의 16개
upright/italic 매트릭스를 유지합니다. 이 빌더는 Geist italic 파일을 임의로
만들지 않습니다. italic 터미널 폰트가 중요해지면 실제 italic 파일이 있는 라틴
소스 프로필을 사용해야 합니다.

## 범위

이 브랜치는 터미널과 IDE 사용을 목표로 합니다. 기본 출력은 Geist Mono 라틴
렌더링, Jetendard의 한글/CJK 맞춤, Nerd Font 심볼을 우선합니다. 기존 Jetendard의
모든 릴리스 워크플로를 보존하려는 목적은 아닙니다.

## 시각 확인 샘플

Jetendard를 yeomil-mono 또는 다른 고정폭 기준 폰트와 비교할 때는 동일한
렌더러, 포인트 크기, 줄 높이를 사용하세요.

```text
Jetendard 테스트 ABC abc 0123456789
가각간갇갈감갑값같꿇뷁힣
한글과 English가 섞인 source comment
if (상태 === "완료") return "성공";
ㄱㄴㄷㅏㅑㅓㅕㅗㅛㅜㅠㅡㅣ
（）［］｛｝，．：；！？
```

## 릴리스 패키징

빌드는 설치 가능한 파일을 `fonts/ttf`, `fonts/otf`, `fonts/webfont` 아래에
기록합니다. upright 및 italic 변형 전반에서 기본 한글 배율을 수동으로 시각
확인한 뒤, 해당 디렉터리에서 릴리스 아카이브를 준비할 수 있습니다. OTF 파일은
생성된 TTF와 동일한 TrueType outline을 사용하는 OTF 호환 출력물입니다.

## 라이선스

Jetendard는 [SIL Open Font License 1.1](LICENSE)에 따라 배포됩니다. 전체
저작권 및 reserved name 고지는 업스트림 JetBrains Mono, Nerd Fonts,
Pretendard, Yeomil Mono 프로젝트를 확인하세요.
