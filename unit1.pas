unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  FileUtil;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonSearch: TButton;
    EditSearch: TEdit;
    EditMask: TEdit;
    EditFolder: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListBox: TListBox;
    procedure ButtonSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ButtonSearchClick(Sender: TObject);
var
  sl, fileContent: TStringList;
  str: String;
  i, counter: Integer;
begin
  counter:= 0;
  ListBox.Clear;
  fileContent := TStringList.Create;
  sl := TStringList.Create;
  sl := FindAllFiles(EditFolder.Text, EditMask.Text, True);
  Label2.Caption:= '';
  try
    for i:=0 to sl.Count-1 do begin
      fileContent.LoadFromFile(sl.Strings[i]);
      str:= AnsiLowerCase(fileContent.Text);
      if str.IndexOf(AnsiLowerCase(EditSearch.Text)) <> -1 then
        begin
          ListBox.Items.Add(sl.Strings[i]);
          Inc(counter);
        end;
      fileContent.Clear;
    end;
    if counter = 0 then
      ShowMessage('No files found !')
    else
      Label2.Caption:= 'Found this word in ' + counter.ToString
        + ' files out of ' + sl.Count.ToString;
  finally
    //ShowMessage(AnsiLowerCase(sl.Text));
    sl.Free;
    fileContent.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.ListBoxClick(Sender: TObject);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.LoadFromFile(ListBox.Items.Strings[ListBox.ItemIndex]);
    ShowMessage(sl.Text);
  finally
    sl.Free;
  end;
end;

end.

