const { Client } = require("pg");

function makeid(length) {
    let result = '';
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const charactersLength = characters.length;
    let counter = 0;
    while (counter < length) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
      counter += 1;
    }
    return result;
}

exports.handler = async (event, context) => {
  const dbConfig = {
        user: 'root',
        password: 'password',
        port: 5432,
        database: 'test_db',
        host: 'database-test.ci0bwbkmi7tv.ap-southeast-1.rds.amazonaws.com',
        ssl: true
    };

  const client = new Client(dbConfig);  
  console.log(99999999999999991);
  
  
  try {
    await client.connect();
     const res1 =  client.query("CREATE TABLE IF NOT EXISTS users(user_id text NOT NULL, name text NOT NULL, age integer NOT NULL)", (err, res) => {
        console.log(err, res);
    });
    const id = makeid(8)
    const res3 =  await client.query(`INSERT INTO "users" ("user_id", "name", "age") VALUES ($1, $2, $3)`, [id, 'duong' , 25], (err, res) => {
        console.log(err, res);
    });
    
    const res = await client.query("SELECT * FROM users");
    await client.end();
    callback(null, res.rows);
  } catch (err) {
    await client.end();
    callback(err)
  }
};
