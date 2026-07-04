#!/usr/bin/env bash
# Scaffold da estrutura de pastas do app "Sépia"
# Uso: rode este script na raiz do seu projeto Flutter (onde fica o pubspec.yaml)
#   chmod +x scaffold_sepia.sh && ./scaffold_sepia.sh

set -e

BASE="lib"

echo "Criando estrutura em $BASE ..."

# ---------- app ----------
mkdir -p "$BASE/app/router"
mkdir -p "$BASE/app/theme"

# ---------- core ----------
mkdir -p "$BASE/core/di"
mkdir -p "$BASE/core/constants"
mkdir -p "$BASE/core/database/tables"
mkdir -p "$BASE/core/errors"
mkdir -p "$BASE/core/extensions"
mkdir -p "$BASE/core/utils"
mkdir -p "$BASE/core/widgets"

# ---------- shared ----------
mkdir -p "$BASE/shared/entities"
mkdir -p "$BASE/shared/widgets"

# ---------- features/gallery ----------
mkdir -p "$BASE/features/gallery/data/datasources"
mkdir -p "$BASE/features/gallery/data/models"
mkdir -p "$BASE/features/gallery/data/repositories"
mkdir -p "$BASE/features/gallery/domain/entities"
mkdir -p "$BASE/features/gallery/domain/repositories"
mkdir -p "$BASE/features/gallery/domain/usecases"
mkdir -p "$BASE/features/gallery/presentation/cubit"
mkdir -p "$BASE/features/gallery/presentation/pages"
mkdir -p "$BASE/features/gallery/presentation/widgets"

# ---------- features/favorites ----------
mkdir -p "$BASE/features/favorites/data/datasources"
mkdir -p "$BASE/features/favorites/data/repositories"
mkdir -p "$BASE/features/favorites/domain/repositories"
mkdir -p "$BASE/features/favorites/domain/usecases"
mkdir -p "$BASE/features/favorites/presentation/cubit"
mkdir -p "$BASE/features/favorites/presentation/pages"

# ---------- features/media_viewer (visualizador de imagem em tela cheia) ----------
mkdir -p "$BASE/features/media_viewer/presentation/cubit"
mkdir -p "$BASE/features/media_viewer/presentation/pages"
mkdir -p "$BASE/features/media_viewer/presentation/widgets"

# ---------- features/video_player ----------
mkdir -p "$BASE/features/video_player/data/datasources"
mkdir -p "$BASE/features/video_player/domain/entities"
mkdir -p "$BASE/features/video_player/domain/usecases"
mkdir -p "$BASE/features/video_player/presentation/cubit"
mkdir -p "$BASE/features/video_player/presentation/pages"
mkdir -p "$BASE/features/video_player/presentation/widgets"

# ---------- features/trash ----------
mkdir -p "$BASE/features/trash/data/datasources"
mkdir -p "$BASE/features/trash/data/repositories"
mkdir -p "$BASE/features/trash/domain/entities"
mkdir -p "$BASE/features/trash/domain/repositories"
mkdir -p "$BASE/features/trash/domain/usecases"
mkdir -p "$BASE/features/trash/presentation/cubit"
mkdir -p "$BASE/features/trash/presentation/pages"

# ---------- features/settings ----------
mkdir -p "$BASE/features/settings/data/datasources"
mkdir -p "$BASE/features/settings/data/repositories"
mkdir -p "$BASE/features/settings/domain/entities"
mkdir -p "$BASE/features/settings/domain/repositories"
mkdir -p "$BASE/features/settings/domain/usecases"
mkdir -p "$BASE/features/settings/presentation/cubit"
mkdir -p "$BASE/features/settings/presentation/pages"
mkdir -p "$BASE/features/settings/presentation/widgets"

# ---------- features/auth_lock (senha/PIN) ----------
mkdir -p "$BASE/features/auth_lock/data/datasources"
mkdir -p "$BASE/features/auth_lock/domain/repositories"
mkdir -p "$BASE/features/auth_lock/domain/usecases"
mkdir -p "$BASE/features/auth_lock/presentation/cubit"
mkdir -p "$BASE/features/auth_lock/presentation/pages"

# ---------- features/camera_shortcut ----------
mkdir -p "$BASE/features/camera_shortcut/presentation"

echo "Estrutura criada com sucesso!"
echo "Rode 'find lib -type d' pra conferir a árvore completa."
