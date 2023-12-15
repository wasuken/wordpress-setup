# ベースイメージとしてDebian 11を使用
FROM debian:11

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    openssh-server \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install pymysql

# SSHの設定
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSHログイン時のメッセージを無効化
RUN sed -i 's/#Banner none/Banner none/' /etc/ssh/sshd_config

# rootユーザーでのSSH接続を許可
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSHポートの公開
EXPOSE 22

# SSHサービスの実行
CMD ["/usr/sbin/sshd", "-D"]
