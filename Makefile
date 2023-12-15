# Dockerコンテナ名とイメージを指定
IMAGE_NAME=ansible-test-image
CONTAINER_NAME=ansible-test
HOST_SSH_PORT=32222
HOST_WORDPRESS_PORT=8080

build:
	docker build -t ${IMAGE_NAME} .

# コンテナの生成
create:
	docker run -d -p ${HOST_SSH_PORT}:22 -p ${HOST_WORDPRESS_PORT}:80 --name $(CONTAINER_NAME) $(IMAGE_NAME)

# コンテナの停止
stop:
	docker stop $(CONTAINER_NAME)

# コンテナの削除
remove: stop
	docker rm $(CONTAINER_NAME)

# コンテナの再生成（削除してから作成）
recreate: remove create

# コンテナの状態確認
status:
	docker ps -a | grep $(CONTAINER_NAME)

test:
	./test.sh

# 利用可能なターゲットの説明
help:
	@echo "利用可能なターゲット:"
	@echo "  build     - 新しいDockerイメージを生成します。"
	@echo "  create     - 新しいDockerコンテナを生成します。"
	@echo "  stop       - 実行中のコンテナを停止します。"
	@echo "  remove     - コンテナを停止し、削除します。"
	@echo "  recreate   - コンテナを削除してから再生成します。"
	@echo "  status     - コンテナの状態を表示します。"
	@echo "  test       - DockerコンテナへAnsibleをながします。"
	@echo "  help       - このヘルプメッセージを表示します。"

# デフォルトのターゲット
.PHONY: create stop remove recreate status help
