# Render Deployment Checklist ✅

## Before Deployment

- [ ] Code is committed to Git
- [ ] GitHub repository created
- [ ] Code pushed to GitHub
- [ ] `config/master.key` saved securely (NOT in GitHub)
- [ ] Render account created

## Files Created for Deployment

✅ `render.yaml` - Render configuration
✅ `bin/render-build.sh` - Build script
✅ `config/database.yml` - Updated for production
✅ `config/puma.rb` - Production server config
✅ `config/initializers/cors.rb` - CORS for frontend

## Environment Variables Needed

Copy these from your local setup to Render:

### 1. RAILS_MASTER_KEY
```bash
# Get your master key:
cat config/master.key
```
→ Copy the output and paste in Render

### 2. DATABASE_URL
→ Copy from Render PostgreSQL "Internal Database URL"

### 3. RAILS_ENV
```
production
```

### 4. FRONTEND_URL
```
https://your-frontend-domain.netlify.app
```
(Update after deploying frontend)

## Deployment Steps

1. **Push to GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial deploy"
   git remote add origin YOUR_GITHUB_REPO_URL
   git push -u origin main
   ```

2. **Create PostgreSQL Database on Render**
   - New + → PostgreSQL
   - Name: `extreme-fitness-db`
   - Free plan

3. **Create Web Service on Render**
   - New + → Web Service
   - Connect GitHub repo
   - Name: `extreme-fitness-api`
   - Runtime: Ruby
   - Build: `./bin/render-build.sh`
   - Start: `bundle exec puma -C config/puma.rb`

4. **Add Environment Variables**
   - Go to Environment tab
   - Add all 4 variables above

5. **Deploy!**
   - Click "Save Changes"
   - Wait for build (5-10 min)

## After Deployment

- [ ] API accessible at: `https://extreme-fitness-api.onrender.com`
- [ ] Test endpoint: `/api/v1/config`
- [ ] Update React app `.env` with new API URL
- [ ] Deploy React frontend
- [ ] Update `FRONTEND_URL` in Render
- [ ] Test login from frontend

## API Endpoints (Production)

```
Base URL: https://extreme-fitness-api.onrender.com/api/v1

POST   /auth/login           - Admin login
GET    /auth/verify          - Verify token
GET    /config               - Gym configuration
GET    /members              - List members
POST   /members              - Create member
GET    /payments             - List payments
POST   /payments             - Record payment
GET    /schedules            - View schedule
```

## Troubleshooting

**Build fails?**
- Check Render build logs
- Verify `render-build.sh` is executable
- Ensure all gems are in `Gemfile.lock`

**Database errors?**
- Verify `DATABASE_URL` is correct
- Check migrations ran successfully

**CORS errors?**
- Update `FRONTEND_URL` with exact URL
- Include `https://` protocol
- No trailing slash

**Slow first request?**
- Normal on free tier (cold start)
- Takes 30-60 seconds to wake up
- Fast after first request

## Admin Credentials

**Email:** Omusotsifredrick24@gmail.com
**Password:** admin123

⚠️ Change password after first production login!

## Need Help?

- Render Docs: https://render.com/docs/deploy-rails
- Deployment Guide: See `RENDER_DEPLOYMENT.md`
