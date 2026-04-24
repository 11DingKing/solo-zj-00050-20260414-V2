"""add deleted_at to commentaries

Revision ID: 20260424_add_deleted_at
Revises: fdf8821871d7
Create Date: 2026-04-24

"""
from typing import Tuple

import sqlalchemy as sa
from alembic import op
from sqlalchemy import func

revision = "20260424_add_deleted_at"
down_revision = "fdf8821871d7"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.add_column(
        "commentaries",
        sa.Column(
            "deleted_at",
            sa.TIMESTAMP(timezone=True),
            nullable=True,
        ),
    )
    op.create_index(
        "ix_commentaries_deleted_at",
        "commentaries",
        ["deleted_at"],
        unique=False,
    )


def downgrade() -> None:
    op.drop_index("ix_commentaries_deleted_at", table_name="commentaries")
    op.drop_column("commentaries", "deleted_at")
