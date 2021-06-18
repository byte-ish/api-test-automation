package com.learn.karate.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol(
    "/api/articles/{articleId}" -> Nil
  )

  //protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val create = scenario("create and delte article").exec(karateFeature("classpath:com/vocalink/pr/performance/articleCreate.feature"))
//  val delete = scenario("delete").exec(karateFeature("classpath:mock/cats-delete.feature@name=delete"))

  setUp(

create.inject(atOnceUsers(3)).protocols(protocol))
}