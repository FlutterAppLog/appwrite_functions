# auto_delete_log_data

自动删除日志数据的云程序

## 初始化
云函数配置变量
BUCKET_ID 存储日志的Bucket ID
DATABASE_ID 数据库ID
LOG_TABLE_ID 存储日志信息的表ID
USER_TABLE_ID 存储用户信息的表ID
APP_LOAD_TABLE_ID 存储APP加载信息的表ID
SENTRY_TABLE_ID 存储Sentry信息的表ID
DAY 需要删除多少天之前的数据