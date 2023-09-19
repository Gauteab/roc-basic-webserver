app "app"
    packages { pf: "../platform/main.roc" }
    imports [pf.Task.{ Task }, pf.Request.{ Request }, pf.Url]
    # imports [pf.Task.{ Task }, pf.Url.{ Url }, pf.Http, pf.Env, pf.Base64]
    # imports [pf.Task.{ Task }, pf.Url.{ Url }, pf.Http, pf.Base64]
    provides [main] to pf

# baseUrl : Str
# baseUrl = "https://localhost:1234"

# TODO split the request URL on a query param which will be another URL, then go hit that URL and include its resp in our response
main : Request -> Task Str []
main = \req ->
    url = Url.fromStr req.url
    path = Url.path url

    dbg url

    if path |> Str.startsWith "/foo/bar" then
        # validateToken url
        Task.ok "Found: \(path)"
    else
        # TODO return HTTP 404
        Task.ok "Not Found: \(path)"

# validateToken : Url -> Task Str []
# validateToken = \_url ->
#     # params = Url.queryParams url

#     task =
#         clientSecret <-
#             Env.var "SECRET"
#             |> Task.mapErr \VarNotFound -> MissingSecretId
#             |> Task.await

#         # dbg clientSecret

#         # TODO causes some sort of signal, e.g. segfault, on repeated requests
#         # clientId <-
#         #     Dict.get params "clientId"
#         #     |> Result.mapErr \KeyNotFound -> MissingClientId
#         #     |> Task.awaitResult

#         {
#             method: Get,
#             headers: [],
#             # url: "\(baseUrl)/introspect",
#             url: "http://example.com",
#             body: Http.emptyBody,
#             timeout: NoTimeout,
#         }
#         |> Http.send
#         # |> Task.mapErr \err ->
#         #     dbg clientSecret
#         #     dbg err
#         #     err

#     result <- Task.attempt task

#     when result is
#         Ok responseBody -> Task.ok "all done: \(responseBody)"
#         Err MissingSecretId -> Task.ok "SECRET not found in env vars"
#         Err MissingClientId -> Task.ok "clientId not found in query param"
#         Err err ->
#             dbg err
#             Task.ok "Oops, something went wrong with the HTTP request!"
