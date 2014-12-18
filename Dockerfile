FROM pataquets/solr:latest

RUN \
	echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu $(lsb_release -cs) main" \
		| tee /etc/apt/sources.list.d/git.list && \
	DEBIAN_FRONTEND=noniteractive \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DF1F24

RUN \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive \
		apt-get -y --no-install-recommends install git-core \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/

RUN \
	git clone --single-branch --branch 7.x-1.7 git://git.drupal.org/project/apachesolr.git ;
	cp -v apachesolr/solr-conf/solr-4.x/* solr/collection1/conf/
