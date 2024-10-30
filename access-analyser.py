import re
import sys
from collections import defaultdict
from datetime import datetime

LOG_PATTERN = (
    r'(?P<ip>\d{1,3}(?:\.\d{1,3}){3}) - - \[(?P<time>.*?)\] "(?P<method>[A-Z]+) '
    r'(?P<path>.*?) HTTP/.*?" (?P<status>\d{3}) (?P<size>\d+) "(?P<referrer>.*?)" "(?P<user_agent>.*?)"'
)

