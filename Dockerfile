FROM pataquets/solr:latest

RUN \
  apt-key adv --keyserver hkp://hkps.pool.sks-keyservers.net --recv-keys E1DF1F24 && \
  . /etc/lsb-release && \
  echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu ${DISTRIB_CODENAME} main" \
    | tee /etc/apt/sources.list.d/git.list \
  && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y --no-install-recommends install git-core \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/

#############################################################################
# Install Apache Solr Drupal module (apachesolr) configuration files.
# - Checkout 7.x-1.7 version git repository.
# - Included mapping-ISOLatin1Accent.txt is not Solr original bacause of
#   licensing issues. Delete module's included file to avoid using it.
# - Overwrite Solr distributed configuration files with Drupal module files.
RUN \
  git clone --single-branch --branch 7.x-1.7 git://git.drupal.org/project/apachesolr.git && \
  rm -v apachesolr/solr-conf/solr-4.x/mapping-ISOLatin1Accent.txt && \
  cp -v apachesolr/solr-conf/solr-4.x/* solr/collection1/conf/
