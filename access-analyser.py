import re
from collections import Counter

COUNT = 10  
PATHL = "/path/log"

def get_ip_adrrs(log_path, count):
    with open(log_path, 'r') as file:
        ip_addr = [line.split()[0] for line in file]
    return Counter(ip_addr).most_common(count)

def get_top_path(log_path, count):
    with open(log_path, 'r') as file:
        paths = [line.split()[0] for line in file if len(line.split()) > 6]
    return Counter(paths).most_common(count)

def get_top_scode(log_path, count):
    with open(log_path, 'r') as file:
        status_codes = re.findall(r' [1-5][0-9]{2} ', file.read())
    return Counter(status_codes).most_common(count)

def get_top_user_agents(log_path, count):
    user_agents = []
    with open(log_path, 'r') as file:
        for line in file:
            parts = line.split('"')
            if len(parts) > 5:
                user_agents.append(parts[5].strip())
    return Counter(user_agents).most_common(count)

print(f"\n=== TOP {COUNT} IP ADDR - HIGH REQUEST ===\n")
for ip, freq in get_ip_adrrs(PATHL, COUNT):
    print(f"{ip} - {freq} requests")

print(f"\n=== TOP {COUNT} PATH MOST REQUESTED ===\n")
for path, freq in get_top_path(PATHL, COUNT):
    print(f"{path} - {freq} requests")

print(f"\n=== TOP {COUNT} STATUS CODE ===\n")
for status, freq in get_top_scode(PATHL, COUNT):
    print(f"{status.strip()} - {freq} requests")

print(f"\n=== TOP {COUNT} USER AGENTS ===\n")
for agent, freq in get_top_user_agents(PATHL, COUNT):
    print(f"{agent} - {freq} requests")
