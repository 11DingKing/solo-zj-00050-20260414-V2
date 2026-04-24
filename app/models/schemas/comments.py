from typing import List

from app.models.domain.comments import Comment
from app.models.schemas.rwschema import RWSchema


class ListOfCommentsInResponse(RWSchema):
    comments: List[Comment]
    comments_count: int


class CommentInResponse(RWSchema):
    comment: Comment


class CommentInCreate(RWSchema):
    body: str
