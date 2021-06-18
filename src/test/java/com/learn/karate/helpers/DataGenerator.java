package com.learn.karate.helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

import java.util.Locale;

public class DataGenerator {

    public static String getRandomEmail() {
        Faker faker = new Faker();
        return faker.name().firstName().toLowerCase(Locale.ROOT) + faker.random().nextInt(0, 100) + "@IshIsTesting.com";

    }

    public static String getRandomUsername() {
        return new Faker().name().username();

    }

    public static JSONObject getRandomArticleValues() {
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("title", title);
        jsonObject.put("description", description);
        jsonObject.put("body", body);
        return jsonObject;
    }
}
