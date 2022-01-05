source /etc/os-release

APT_SOURCE="/etc/apt/sources.list"

if [ ! -f ${APT_SOURCE}_bk ]; then
    cp ${APT_SOURCE} ${APT_SOURCE}_bk
fi

SOURCES=(
    "https://mirrors.tuna.tsinghua.edu.cn/ubuntu/"
    "https://mirrors.aliyun.com/ubuntu/"
    "http://cn.archive.ubuntu.com/ubuntu/"
)

# 官方源(ubuntu)
# "http://cn.archive.ubuntu.com/ubuntu/"

echo "deb ${SOURCES[${INDEX}]} ${VERSION_CODENAME} main restricted universe multiverse
deb ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-updates main restricted universe multiverse
deb ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-security main restricted universe multiverse
deb ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-proposed main restricted universe multiverse
deb ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-backports main restricted universe multiverse" >${APT_SOURCE}

# 不建议使用 预发布源?
# deb-src ${SOURCES[${INDEX}]} ${VERSION_CODENAME} main restricted universe multiverse
# deb-src ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-security main restricted universe multiverse
# deb-src ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-updates main restricted universe multiverse
# deb-src ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-proposed main restricted universe multiverse
# deb-src ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-backports main restricted universe multiverse

apt update
