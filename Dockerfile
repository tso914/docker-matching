FROM centos:latest

# Install python 3.6.0 and pip3 and python-dev headers for pypostal
RUN yum -y update
RUN yum -y install \
    gcc \
    make \
    git \
    curl \
    autoconf \
    automake \
    libtool \
    pkgconfig \
    yum-utils \
	libcurl \
	libcurl-devel \
    https://centos7.iuscommunity.org/ius-release.rpm

RUN yum -y install \
    python36u \
    python36u-devel \
    python36u-pip \
    postgresql \
	postgresql-libs \
    postgresql-devel \
	python36u-tkinter 
	
RUN yum -y install \
    krb5-devel	\
	krb5-workstation
	
# Install libpostal
RUN git clone https://github.com/openvenues/libpostal && \
    cd libpostal && \
    ./bootstrap.sh && \
    ./configure --prefix=/usr --datadir=/opt/libpostaldata && \
    make && \
    make install

# Install pypostal
RUN pip3.6 install --upgrade pip postal \
    happybase \
    pandas \
    jsonschema \
    numpy \
    psycopg2 \ 
    SQLAlchemy \
    xlrd \
    matplotlib \
    scipy \
    statsmodels \
    patsy \
	six \
	requests \
	requests-kerberos \
	plotly \
	requests-toolbelt \
	boto \
	bz2file \
	cycler \
	decorator \
	fpdf \
	httpretty \
	imbalanced-learn \
	ipython-genutils \
	jupyter-core \
	lime \
	mlxtend \
	nbformat \
	nose \
	pathtools \
	py \
	py2neo \
	pyparsing \
	pytest \
	python-dateutil \
	pytz \
	PyYAML \
	ruamel.yaml \
	scikit-learn \
	seaborn \
	smart-open \
	SQLAlchemy \
	statsmodels \
	traitlets \
	XlsxWriter \
	probablepeople \
	wordninja \
	multiprocess 
	
	
RUN pip3.6 install --no-cache-dir --compile --ignore-installed --install-option="--with-nss" pycurl==7.43.0.1	

# Create symlinks for the C objects (so we dont need to set LD_LIBRARY_PATH).
RUN ln -s /usr/lib/libpostal.a /usr/lib64/libpostal.a
RUN ln -s /usr/lib/libpostal.la /usr/lib64/libpostal.la
RUN ln -s /usr/lib/libpostal.so /usr/lib64/libpostal.so
RUN ln -s /usr/lib/libpostal.so.1 /usr/lib64/libpostal.so.1
RUN ln -s /usr/lib/libpostal.so.1.0.0 /usr/lib64/libpostal.so.1.0.0

# Create a 'data' volume for mounting external post data
VOLUME /data

# Create a 'source' volume for mounting external python source files.
VOLUME /src

# bash as a default command (but allow to be overridden by anything else supplied on CMD line)
CMD bash
