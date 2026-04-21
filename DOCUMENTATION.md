##  Setup Instructions
1. **Database**: Ensure WAMP is running. Run `php create_db.php` from the root to initialize the `plant_simulation` DB.
2. **Backend**: 
    - `cd backend`
    - `php artisan migrate`
    - `php artisan serve --port=8000`
3. **Frontend**:
    - `cd frontend`
    - `npm install`
    - `npm run dev -- --port 3000`

