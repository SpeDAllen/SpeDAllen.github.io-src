AUTHOR = 'SpeDAllen'
SITENAME = '"My new blog"'
SITESUBTITLE = 'Explore, learn, code, contribue, improve'
SITEURL = ''

PATH = 'content'
# static paths will be copied without parsing their contents
STATIC_PATHS = ['pdfs', 'images', 'scripts', 'source']
ARTICLE_PATHS = ['blog']
PAGE_PATHS = ['pages']
ARTICLE_SAVE_AS = '{date:%Y}/{slug}.html'
ARTICLE_URL = '{date:%Y}/{slug}.html'
USE_FOLDER_AS_CATEGORY = True
DEFAULT_CATEGORY = 'Blog'
DEFAULT_DATE = 'fs'

TIMEZONE = 'Europe/Rome'

DEFAULT_LANG = 'en'

THEME = "./pelican-twitchy-mod/"
RECENT_POST_COUNT = 5
EXPAND_LATEST_ON_INDEX = True
DISPLAY_RECENT_POSTS_ON_MENU = True
BOOTSTRAP_THEME = "lumen"
OPEN_GRAPH = True
TYPOGRIFY = False

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
LINKS = (('My GitHub', 'https://github.com/SpeDAllen'),)

# Social widget
# SOCIAL = (('You can add links in your config file', '#'),
#           ('Another social link', '#'),)

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True

# PLUGIN_PATHS = ['./pelican-plugins']
# PLUGINS = ['org_reader']
# ORG_READER_EMACS_LOCATION = 'emacs'
# ORG_READER_EMACS_SETTINGS = './pelican.el'
