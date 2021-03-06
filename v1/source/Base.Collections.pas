unit Base.Collections;

interface

uses
  Base.Utils;

type

  TCollectionsSQL = record
  strict private
    const
      OPERATOR_LOGICAL: array [ TOperatorLogical ] of string = ( '', ' and ', ' or ' );
      OPERATOR_COMPARISON : array [ TOperatorComparison ] of string = ( '', ' = ' );

    type
      RCollectionSQL = record
        Table: string;
        Field: string;
        Value: Variant;

        OperatorComparison: TOperatorComparison; // =, >=, <=
        OperatorLogical: TOperatorLogical; // and, or

      end;
      RCollectionsSQL = array of RCollectionSQL;

  strict private
    FCollection: RCollectionsSQL;

    procedure Insert( const ATable: string; const AField: string; AValue: Variant;
      const AOperatorComparison: TOperatorComparison; const AOperatorLogical : TOperatorLogical );

  public
    property Collection: RCollectionsSQL read FCollection;
    procedure Add( const ATable: string; const AField: string; AValue: Variant ); overload;

    procedure Add( const ATable: string; const AField: string; AValue: Variant;
      const AOperatorComparison: TOperatorComparison; const AOperatorLogical : TOperatorLogical ); overload;

    function Count(): Integer;
    function IsEmpty(): Boolean;

    function ComparisonAsText( const AOperatorComparison: TOperatorComparison ): string;
    function LogicalAsText( const AOperatorLogical : TOperatorLogical ): string;

  end;

implementation



{ TCollectionsSQL }



procedure TCollectionsSQL.Add(const ATable, AField: string; AValue: Variant);
begin
  Insert( ATable, AField, AValue, topcompEmpty, toplogEmpty );

end;



procedure TCollectionsSQL.Add(const ATable, AField: string; AValue: Variant;
  const AOperatorComparison: TOperatorComparison; const AOperatorLogical : TOperatorLogical );
begin
  Insert( ATable, AField, AValue,
    AOperatorComparison, AOperatorLogical );

end;



function TCollectionsSQL.ComparisonAsText(
  const AOperatorComparison: TOperatorComparison): string;
begin
  Result:=
    OPERATOR_COMPARISON[ AOperatorComparison ];
end;


function TCollectionsSQL.LogicalAsText(const AOperatorLogical: TOperatorLogical): string;
begin
  Result:=
    OPERATOR_LOGICAL[ AOperatorLogical ];
end;



function TCollectionsSQL.Count: Integer;
begin
  Result:=
    Length( FCollection )
end;



procedure TCollectionsSQL.Insert(const ATable, AField: string; AValue: Variant;
  const AOperatorComparison: TOperatorComparison; const AOperatorLogical : TOperatorLogical );

var
  TamanhoArray: Integer;
begin
  TamanhoArray:= Length( FCollection );

  SetLength( FCollection , TamanhoArray + 1 );

  FCollection[ TamanhoArray ].Table:= ATable;
  FCollection[ TamanhoArray ].Field:= AField;
  FCollection[ TamanhoArray ].Value:= AValue;
  FCollection[ TamanhoArray ].OperatorComparison:= AOperatorComparison;
  FCollection[ TamanhoArray ].OperatorLogical:= AOperatorLogical;

end;



function TCollectionsSQL.IsEmpty: Boolean;
begin
  Result:=
    Count = 0;
end;



end.
