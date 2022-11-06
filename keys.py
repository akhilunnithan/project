import json
object = '{"a": {"b": {"c": "d"} } }'
res=json.loads(object)

key = 'a/b/c'
keys = key.split('/')
length= len(keys)

for i in range(length):
   
   if i == 0:
      res_key_1 = (keys[i])
      if length == 1:
         print (res[res_key_1])
   if i == 1:
      res_key_2 = (keys[i])
      if length == 2:
         print (res[f"{res_key_1}"][res_key_2])
   if i == 2:
      res_key_3 = keys[i]
      if length == 3:
         print (res[res_key_1][res_key_2][res_key_3])

# for i in res:
#     for j in res[i]:
#         print (res[i][j])