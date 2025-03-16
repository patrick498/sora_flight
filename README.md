# 📚 Sora Flight

A web app where users rent luxury vehicles—cars, private jets, yachts—while owners can list and manage their rentals seamlessly.

![Sora Vehicles Screenshot](https://github.com/user-attachments/assets/025f3522-23e0-4c7b-a2bd-84db556c0f04)

<br>
App home: https://sora-flight.games


## Getting Started
### Setup

Install gems
```
bundle install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables. For any APIs, see group Slack channel.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
MAPBOX_API_KEY=your_own_mapbox_api_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping


## Team Members
- [André Yuki Ide](https://www.linkedin.com/in/andreide/)
- [Axel Bailleres](https://www.linkedin.com/in/axel-bailleres-67506a311/)
- [Patrick Pailhes](https://www.linkedin.com/in/patrick-pailhes-48b141327/)
- [Yu Sekiguchi](https://www.linkedin.com/in/yu-sekiguchi/)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License
