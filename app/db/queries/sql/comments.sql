-- name: get-comments-for-article-by-slug
SELECT c.id,
       c.body,
       c.created_at,
       c.updated_at,
       c.deleted_at,
       (SELECT username FROM users WHERE id = c.author_id) as author_username
FROM commentaries c
         INNER JOIN articles a ON c.article_id = a.id AND (a.slug = :slug)
ORDER BY c.created_at ASC;

-- name: get-comment-by-id-and-slug^
SELECT c.id,
       c.body,
       c.created_at,
       c.updated_at,
       c.deleted_at,
       (SELECT username FROM users WHERE id = c.author_id) as author_username
FROM commentaries c
         INNER JOIN articles a ON c.article_id = a.id AND (a.slug = :article_slug)
WHERE c.id = :comment_id
  AND c.deleted_at IS NULL;

-- name: create-new-comment<!
WITH users_subquery AS (
        (SELECT id, username FROM users WHERE username = :author_username)
)
INSERT
INTO commentaries (body, author_id, article_id)
VALUES (:body,
        (SELECT id FROM users_subquery),
        (SELECT id FROM articles WHERE slug = :article_slug))
RETURNING
    id,
    body,
        (SELECT username FROM users_subquery) AS author_username,
    created_at,
    updated_at,
    deleted_at;

-- name: soft-delete-comment-by-id!
UPDATE commentaries
SET deleted_at = NOW()
WHERE id = :comment_id
  AND author_id = (SELECT id FROM users WHERE username = :author_username)
  AND deleted_at IS NULL;

-- name: soft-delete-comments-by-article-id!
UPDATE commentaries
SET deleted_at = NOW()
WHERE article_id = :article_id
  AND deleted_at IS NULL;

-- name: get-comments-count-for-article-by-slug^
SELECT count(*) as comments_count
FROM commentaries c
         INNER JOIN articles a ON c.article_id = a.id AND (a.slug = :slug)
WHERE c.deleted_at IS NULL;
