# Extreme Fitness Centre - Render Deployment Guide

## 📋 Prerequisites

1. **GitHub Account** - Your code must be in a GitHub repository
2. **Render Account** - Sign up at [render.com](https://render.com)
3. **Rails Master Key** - Located in `config/master.key`

## 🚀 Step-by-Step Deployment

### Step 1: Push Code to GitHub

```bash
cd /Users/bryanbosire/projects/gym_fitness/extreme-fitness-api

# Initialize git if not already done
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - Extreme Fitness Centre API"

# Add your GitHub remote (replace with your repo URL)
git remote add origin https://github.com/YOUR_USERNAME/extreme-fitness-api.git

# Push to GitHub
git push -u origin main
```

### Step 2: Deploy on Render

#### Option A: Using render.yaml (Recommended)

1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click **"New +"** → **"Blueprint"**
3. Connect your GitHub repository
4. Render will automatically detect the `render.yaml` file
5. Click **"Apply"**

#### Option B: Manual Setup

1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click **"New +"** → **"PostgreSQL"**
   - Name: `extreme-fitness-db`
   - Plan: Free
   - Click **"Create Database"**

3. Click **"New +"** → **"Web Service"**
   - Connect your GitHub repository
   - Name: `extreme-fitness-api`
   - Runtime: **Ruby**
   - Build Command: `./bin/render-build.sh`
   - Start Command: `bundle exec puma -C config/puma.rb`
   - Plan: Free

### Step 3: Set Environment Variables

In your Render Web Service, go to **"Environment"** and add:

#### Required Environment Variables:

1. **RAILS_MASTER_KEY**
   ```
   Value: [Get from config/master.key file]
   ```

2. **DATABASE_URL**
   ```
   Value: [Copy from your PostgreSQL database's Internal Database URL]
   ```

3. **RAILS_ENV**
   ```
   Value: production
   ```

4. **FRONTEND_URL**
   ```
   Value: https://your-frontend-app.netlify.app
   (Update this after deploying your frontend)
   ```

### Step 4: Get Your Master Key

Run this command to display your master key:

```bash
cat /Users/bryanbosire/projects/gym_fitness/extreme-fitness-api/config/master.key
```

Copy the output and paste it as the `RAILS_MASTER_KEY` value in Render.

### Step 5: Deploy

1. Click **"Save Changes"** in Render
2. Render will automatically build and deploy your app
3. Wait for the build to complete (5-10 minutes)
4. Your API will be available at: `https://extreme-fitness-api.onrender.com`

## 🔍 Verify Deployment

Test your deployed API:

```bash
# Test config endpoint
curl https://extreme-fitness-api.onrender.com/api/v1/config

# Should return JSON with gym configuration
```

## 📝 Important Notes

### Rails Master Key
- **NEVER commit `config/master.key` to GitHub**
- It should already be in `.gitignore`
- Store it securely (password manager, secure notes)

### Database
- Render's free PostgreSQL tier will automatically sleep after inactivity
- It will wake up on the first request (may take 30-60 seconds)

### Cold Starts
- Free tier services sleep after 15 minutes of inactivity
- First request after sleeping takes 30-60 seconds
- Subsequent requests are fast

## 🔧 Troubleshooting

### Build Fails
1. Check build logs in Render dashboard
2. Ensure all gems are in `Gemfile.lock`
3. Verify `bin/render-build.sh` is executable

### Database Connection Issues
1. Verify `DATABASE_URL` is set correctly
2. Check that Rails can parse the connection string
3. Look for migration errors in logs

### CORS Errors
1. Make sure `FRONTEND_URL` matches your deployed frontend exactly
2. Include the protocol (`https://`)
3. No trailing slash

## 📊 After Deployment

### Update Frontend
Update your React app's API URL to point to Render:

```env
REACT_APP_API_URL=https://extreme-fitness-api.onrender.com/api/v1
```

### Test Login
1. Visit your deployed frontend
2. Login with: Omusotsifredrick24@gmail.com / admin123
3. Verify all features work

## 🔄 Redeployment

Any push to your GitHub main branch will automatically trigger a new deployment on Render.

```bash
git add .
git commit -m "Update feature"
git push origin main
```

## 📞 Support

- Render Docs: https://render.com/docs
- Rails Deployment: https://render.com/docs/deploy-rails

## 🎉 Your API URLs

After deployment, your endpoints will be:

- **Config**: `https://extreme-fitness-api.onrender.com/api/v1/config`
- **Login**: `https://extreme-fitness-api.onrender.com/api/v1/auth/login`
- **Members**: `https://extreme-fitness-api.onrender.com/api/v1/members`
- **Payments**: `https://extreme-fitness-api.onrender.com/api/v1/payments`
- **Schedule**: `https://extreme-fitness-api.onrender.com/api/v1/schedules`
