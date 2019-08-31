
db.createUser(
     {
       user:"root",
       pwd:"root",
       roles:[{role:"root",db:"admin"}]
     }
  )
./bin/mongod --dbpath=data --logpath=logs

use admin
db.createUser(
     {
       user:"root",
       pwd:"root",
       roles:[{role:"root",db:"admin"}]
     }
  )
db.auth('root','root')

use  elevator
db.createUser(
     {
       user:"ele",
       pwd:"ele2018",
       roles:[{role:"readWrite",db:"elevator"}]
     }
  )
db.auth('ele','ele2018')

use  ele_wopen_base
db.createUser(
     {
       user:"wesyncall",
       pwd:"wesyncall123!@#",
       roles:[{role:"readWrite",db:"ele_wopen_base"}]
     }
  )
db.auth('wesyncall','wesyncall123!@#')
