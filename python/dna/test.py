names = ["bob", "bob", "bob", "alice", "alice", "charlie"]

profiles = []
for index, x in enumerate(set(names)):
    count = 0
    profile = {'name': x, 'count': 0}
    profiles.append(profile)
    for y in names:
        if x == y:
            count += 1
        profile['count'] = count

winner = [x['name'] for x in profiles if x['count'] == max([x['count'] for x in profiles])]
print(winner[0])
