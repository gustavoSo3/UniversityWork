This is a [Next.js](https://nextjs.org/) project bootstrapped with [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the pages by modifying the files at `src/app/`. UI components are defined at `src/components/`. The pages auto-updates as you edit the files. Public assets are at the `public/` folder.

## Building

Run `npm run build` to build the app for production. The build artifacts will be stored in the `.next/` directory.

### Docker image build
Run `docker build -t tucasita-app .` to build the docker image.

## Run locally

Run `npm run start` to start the app in production mode. The app will be served at [http://localhost:3000](http://localhost:3000).

### Docker image run
Run `docker run -p 3000:3000 tucasita-app` to run the docker image.

## Deploying
Follow Deploying to Amazon ECS using Github Actions at https://docs.github.com/en/actions/deployment/deploying-to-your-cloud-provider/deploying-to-amazon-elastic-container-service

Ensure the user defined for deployment has enough iam permissions. See [iam-tucasita-deploy](ops/manual/iam-tucasita-deploy.json)
