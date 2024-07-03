# Chap. 09

## Local

```sh
npm install
npx wrangler d1 execute b4nma-hono --config wrangler.local.toml --local --file=./schema.sql
npx wrangler d1 execute b4nma-hono --config wrangler.local.toml --local --command="select * from balls"
npm run dev
```

## Remote

```sh
npx wrangler login
npx wrangler d1 create b4nma-hono
npx wrangler d1 execute b4nma-hono --config wrangler.remote.toml --remote --file=./schema.sql
npx wrangler d1 execute b4nma-hono --config wrangler.remote.toml --remote --command="select * from balls"
npm run deploy
```
