How to deploy a poussette instance on heroku :


```
git clone git@github.com:Studyka/poussette.git
cd poussette
heroku create <your-app>
heroku config:set SECRET=poussette
heroku addons:add redistogo --app poussette-staging
git push heroku master
```
