#[macro_use]
extern crate rocket;

use rocket::fs::{FileServer, relative};
use rocket_dyn_templates::{Template, context};

#[get("/")]
fn index() -> Template {
    Template::render("index", context! { 
        title: "When should I choose server side rendering?", 
        body: "I have noticed that minimalistic websites has disappeared.  This is sad."
    })
}

#[launch]
fn rocket() -> _ {
    rocket::build()
        .attach(Template::fairing())
        .mount("/", FileServer::from(relative!("static")))
        .mount("/", routes![index])
}
