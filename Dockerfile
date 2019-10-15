FROM kaggle/python

RUN apt -y update
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN apt -y install build-essential libpcre3-dev python3 python3-pip curl zip unzip swig

RUN echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LANG ru_RU.UTF-8

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN curl -sL https://github.com/dangerink/udpipe/archive/load_binary.zip -o /tmp/udpipe.zip &&     cd /tmp &&     unzip -qo /tmp/udpipe.zip  &&     cd /tmp/udpipe-load_binary/releases/pypi &&     ./gen.sh 1.2.0.1.0 &&     cd ufal.udpipe &&     python3 setup.py install &&     cd /tmp &&     rm -rf /tmp/udpipe*

RUN pip install tqdm pymystem3
RUN pip install dawg https://github.com/kmike/pymorphy2/archive/master.zip pymorphy2-dicts-ru
RUN pip install -U pymorphy2-dicts-ru

RUN python -c "import pymystem3.mystem ; pymystem3.mystem.autoinstall()"
RUN python -c "import nltk; nltk.download('stopwords'); nltk.download('punkt');"

RUN pip install jellyfish
