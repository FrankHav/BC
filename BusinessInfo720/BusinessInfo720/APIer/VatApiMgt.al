codeunit 6231702 VatApiMgt720
{

    var
        url: Label 'https://api.test.businessinfo720.com/api/standard', Locked = true;

    procedure RunTest(vat: text): list of [Text];
    var
        payload: Text;
        jsonObject: JsonObject;
        ResultArray: list of [Text];
    begin

        jsonObject.Add('key', '?12#D06181B2-9098-4D6B-9A89-8D6693F2B1A8');
        jsonObject.Add('parameter', 'get_BusinessInfo');
        jsonObject.Add('country', 'DK');
        jsonObject.Add('vat', vat);
        jsonObject.WriteTo(payload);
        ResultArray := (MakeRequest(url, payload));
        exit(ResultArray);
    end;

    local procedure MakeRequest(uri: Text; payload: Text): list of [Text];
    var
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;
        IsSuccessful: Boolean;
        resultArray: List of [Text];
        responseText: Text;
    begin
        content.WriteFrom(payload);
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        contentHeaders.Add('AccessKey', 'AFBB74FF-04F0-4B52-A9AF-190518646EB8');
        request.Content := content;
        request.SetRequestUri(uri);
        request.Method := 'POST';
        IsSuccessful := client.Send(request, response);
        if not response.IsSuccessStatusCode then
            Message(response.ReasonPhrase + ' ' + Format(response.HttpStatusCode));
        response.Content().ReadAs(responseText);
        resultArray := ParseJsonResult(responseText);
        exit(resultArray);
    end;

    local procedure ParseJsonResult(Input: Text): list of [Text]
    var
        JsonObj: JsonObject;
        sentencesArray: JsonArray;
        jsontok: JsonToken;
        resulttxt: Text;
        i: Integer;

        ResultArray: list of [Text];
    begin
        JsonObj.ReadFrom(Input);
        JsonObj.Get('data', jsontok);
        sentencesArray := jsontok.AsArray();

        for i := 0 to sentencesArray.Count() - 1 do begin
            sentencesArray.Get(i, jsontok);
            jsontok.WriteTo(resulttxt);
            ResultArray.Add(resulttxt);
        end;

        exit(ResultArray);

    end;
}