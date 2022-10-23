use serde::{Deserialize, Serialize};
use serde_yaml::{self};
use std::fmt::Debug;
use std::fs::File;

#[derive(Debug, Serialize, Deserialize)]
pub struct Post {
    pub slug: String,
    pub title: String,
    pub body: String,
    pub date: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct Config {
    pub title: String,
    pub description: String,
    pub default: String,
    pub posts: Vec<Post>,
}

impl Config {
    pub fn new() -> Self {
        let file = File::open("./config.yml").expect("Could not open file.");
        let config = serde_yaml::from_reader(file).expect("Could not read values.");
        config
    }
}
