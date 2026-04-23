# FastAPI RealWorld Example App

## 项目简介
基于 FastAPI 实现的 RealWorld (Conduit) 后端 API，使用 PostgreSQL + asyncpg 异步数据库驱动，支持用户认证、文章 CRUD、评论、标签、收藏、关注等功能。采用分层架构（api/core/db/models/services）。

## 快速启动

### Docker 启动（推荐）

```bash
# 克隆项目
git clone <GitHub 地址>
cd solo-zj-00050-20260414

# 复制环境变量
cp .env.example .env

# 启动所有服务
docker compose up -d

# 查看运行状态
docker compose ps
```

### 访问地址

| 服务 | 地址 | 说明 |
|------|------|------|
| 后端 API | http://localhost:8000 | FastAPI 主服务 |
| API 文档 | http://localhost:8000/docs | Swagger 文档 |
| PostgreSQL | localhost:5432 | 数据库 |

### 停止服务

```bash
docker compose down
```

## 项目结构
- `app/api/` - API 路由和错误处理
- `app/core/` - 配置和事件
- `app/db/` - 数据库仓库和查询
- `app/models/` - 数据模型
- `app/services/` - 业务逻辑
- `tests/` - 测试

## 来源
- 原始来源: https://github.com/nsidnev/fastapi-realworld-example-app
- GitHub（上传）: https://github.com/11DingKing/solo-zj-00050-20260414
