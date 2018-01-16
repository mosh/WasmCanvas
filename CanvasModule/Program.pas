namespace CanvasModule;

type
  [Export]
  Program = public class

  private

    method FillCanvasJS(elementId:String; fillStyle:String; x:Integer; y:Integer; width:Integer; height:Integer);
    begin
      WebAssembly.Global.Call("fillCanvas",[elementId, fillStyle, x, y, width, height]);
    end;

    method FillCanvasCode(elementId:String; fillStyle:String; x:Integer; y:Integer; width:Integer; height:Integer);
    begin
      var canvas := WebAssembly.GetElementById(elementId);
      var ctx := EcmaScriptObject(canvas.Call('getContext', '2d'));

      ctx.Items['fillStyle'] :=  fillStyle;
      ctx.Call('fillRect', [ x, y, width, height]);

    end;

  public

    //https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API/Tutorial/Basic_usage

    method AllInCode;
    begin

      FillCanvasCode('secondCanvas','rgb(200, 0, 0)',10,10,50,50);
      FillCanvasCode('secondCanvas','rgba(0, 0, 200, 0.5)',30, 30, 50, 50);

    end;

    method CallOutToJScript;
    begin

      FillCanvasJS('firstCanvas','rgb(200, 0, 0)',10,10,50,50);
      FillCanvasJS('firstCanvas','rgba(0, 0, 200, 0.5)',30, 30, 50, 50);

    end;

  end;

end.