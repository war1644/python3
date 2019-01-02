FROM registry.cn-beijing.aliyuncs.com/dxq_docker/base
LABEL author=ahmerry@qq.com

# python3 镜像
RUN apk add --no-cache python3 && \
# pip
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    echo "[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple" > /etc/pip.conf && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    pip install --upgrade pip setuptools && \
    rm -r /root/.cache

#开放端口
#EXPOSE 7878
#外部配置
#COPY config/conf /etc/pyhton3
COPY shell /shell

# 健康检查 --interval检查的间隔 超时timeout retries失败次数
#HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
#    CMD netstat -an | grep : || exit 1
# 启动
CMD ["/shell/start.sh"]
