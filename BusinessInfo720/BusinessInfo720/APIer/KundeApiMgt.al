codeunit 6231701 KundeApiMgt720
{
    var
        url: Label 'https://businessinfotest-20230904133150.azurewebsites.net/api/businessinfo', Locked = true;

    procedure RunVat(vat: text): list of [Text];
    var
        payload: Text;
        jsonObject: JsonObject;
        DetGodeOutput: Text;
        rec: Record Customer;
        ResultArray: list of [Text];
    begin
        jsonObject.Add('country', 'DK');
        jsonObject.Add('vat', vat);
        jsonObject.Add('name', '');
        jsonObject.WriteTo(payload);
        ResultArray := (MakeRequest(url, payload));
        exit(ResultArray);
    end;

    procedure RunName(name: text): list of [Text];
    var
        payload: Text;
        jsonObject: JsonObject;
        DetGodeOutput: Text;
        rec: Record Customer;
        ResultArray: list of [Text];
    begin
        jsonObject.Add('country', 'DK');
        jsonObject.Add('vat', '');
        jsonObject.Add('name', name);
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
        contentHeaders.Add('AccessKey', 'accessKey');
        request.Content := content;
        request.SetRequestUri(uri);
        request.Method := 'POST';
        IsSuccessful := client.Send(request, response);
        if not IsSuccessful then begin
            Error('Fejl 40');
        end;
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
        if not JsonObj.ReadFrom(Input) then exit;
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