unit define;

interface

uses
  Winapi.Winsock2, Winapi.WinSock, Winapi.Windows;

//const
//  nsqip = '192.168.1.100';

const
  NL = #10;
  MAGIC_V2 = '  V2';

type
  FrameType = (FRAMETYPERESPONSE, FRAMETYPEERROR, FRAMETYPEMESSAGE);

function fromInt(typeId: Integer): FrameType;

function ComputerName: string;

var
  nsqip: string;

implementation

function fromInt(typeId: Integer): FrameType;
begin
  case (typeId) of

    0:
      result := FrameType.FRAMETYPERESPONSE;
    1:
      result := FrameType.FRAMETYPEERROR;
    2:
      result := FrameType.FRAMETYPEMESSAGE;
  end;

end;

function ComputerName: string; //��ȡ���������
var
  wVersionRequested: WORD;
  wsaData: TWSAData;
  p: PHostEnt;
  s: array[0..128] of char;
begin
  try
    wVersionRequested := MAKEWORD(1, 1); //���� WinSock
    WSAStartup(wVersionRequested, wsaData); //���� WinSock
    GetHostName(@s, 128);
    p := GetHostByName(@s);
    Result := p^.h_Name;
  finally
    WSACleanup; //�ͷ� WinSock
  end;
end;

end.

