#[macro_use]
extern crate rocket;

use rocket::fs::{relative, FileServer};
use rocket_dyn_templates::{context, Template};

mod config;

#[get("/")]
fn index() -> Template {
    let config = config::Config::new();
    current(config.default)
}

#[get("/<current>")]
fn current(current: String) -> Template {
    let config = config::Config::new();
    Template::render(
        "index",
        context! {
            title: config.title,
            description: config.description,
            posts: config.posts,
            current: current,
        },
    )
}

#[get("/content/<slug>")]
fn content(slug: String) -> Template {
    let config = config::Config::new();
    let post = config.posts.iter().find(|post| post.slug == slug).unwrap();
    Template::render(
        "content",
        context! {
            slug: post.slug.clone(),
            title: post.title.clone(),
            author: post.author.clone(),
            date: post.date.clone(),
            body: post.render(),
        },
    )
}

#[launch]
fn rocket() -> _ {
    rocket::build()
        .attach(Template::fairing())
        .mount("/", FileServer::from(relative!("static")))
        .mount("/", routes![index, current, content])
}
