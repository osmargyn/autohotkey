#SingleInstance, force
#IfWinActive
;preenche o valor base de icms e aliquota
^Numpad1::
{

    ; armazena o valor total liquido do produto na variavel
	; ControlGetText, ValorLiqRaw, TCampoInterno5,

	; variavel tipo vetor
    OpcoesLançamentoManualdeTributos := ["1. Redução 12 para 7","2. Redução 12 para 11","3. Redução 17 para 7","4. Redução 17 para 11","5. Redução 17 para 12","6. ICMS Integral (CST 00)"]
    opcao1 := OpcoesLançamentoManualdeTributos[1] ; 1. Redução 12 para 7
    opcao2 := OpcoesLançamentoManualdeTributos[2] ; 2. Redução 12 para 11
    opcao3 := OpcoesLançamentoManualdeTributos[3] ; 3. Redução 17 para 7
    opcao4 := OpcoesLançamentoManualdeTributos[4] ; 4. Redução 17 para 11
    opcao5 := OpcoesLançamentoManualdeTributos[5] ; 5. Redução 17 para 12
    opcao6 := OpcoesLançamentoManualdeTributos[6] ; 6. ICMS Integral (CST 00)

	; somente para teste
	ValorLiqRaw := "250,00"

    ; Substituindo a vírgula pelo ponto
    ValorLiq := StrReplace(ValorLiqRaw, ",", ".")

	; declaração de variavéis
	Reducao1 := 58.33 ;= 12% Para  7%
	Reducao2 := 91.67 ;= 12% Para 11%
	Reducao3 := 41.18 ;= 17% Para  7%
	Reducao4 := 64.71 ;= 17% Para 11%
	Reducao5 := 70.59 ;= 17% Para 12%

	; calculo da redução sobre o valor total liquido do produto
	CalcICMS1 := ValorLiq * (Reducao1 / 100)
	CalcICMS2 := ValorLiq * (Reducao2 / 100)
	CalcICMS3 := ValorLiq * (Reducao3 / 100)
	CalcICMS4 := ValorLiq * (Reducao4 / 100)
	CalcICMS5 := ValorLiq * (Reducao5 / 100)

	; faz o arredondamento
	CalcICMSArredondado1 := Round(CalcICMS1 * 100) / 100
	CalcICMSArredondado2 := Round(CalcICMS2 * 100) / 100
	CalcICMSArredondado3 := Round(CalcICMS3 * 100) / 100
	CalcICMSArredondado4 := Round(CalcICMS4 * 100) / 100
	CalcICMSArredondado5 := Round(CalcICMS5 * 100) / 100

	; Substituindo a vírgula pelo ponto
	ValorICMS1 := StrReplace(CalcICMSArredondado1, ".", ",")
	ValorICMS2 := StrReplace(CalcICMSArredondado2, ".", ",")
	ValorICMS3 := StrReplace(CalcICMSArredondado3, ".", ",")
	ValorICMS4 := StrReplace(CalcICMSArredondado4, ".", ",")
	ValorICMS5 := StrReplace(CalcICMSArredondado5, ".", ",")
	; salva e abre janela para lançamento manual de tributos
	; Send, {F4}
	; aguarda janela abrir
	; WinWait, ahk_class TFNFeTributosManuais
	; se a janela estiver ativa o if é execultado
    ; if(WinActive("Base de calculo")){
	    ;CSTICMS() ; substitui por 20
	    InputBox, VlrBaseICMS, Lançamento Manual de Tributos, Digite a opção desejada:`n`n%opcao1%`n%opcao2%`n%opcao3%`n%opcao4%`n%opcao5%`n%opcao6%, , 250, 280  ; tamanho da janela = comprimento(250), altura(280)
	    Switch VlrBaseICMS
	    {
		    Case "1": ; redução 12 para 7(58,33%)
                MsgBox, a redução 12 para 7 `(58,33`%`) é:`n%ValorICMS1%

		    Case "2": ; redução 12 para 11(91,67%)
                MsgBox, redução 12 para 11 `(91,67`%`) é:`n%ValorICMS2%

		    Case "3": ; redução 17 para 7(41,18%)
                MsgBox, redução 17 para 7 `(41,18`%`) é:`n%ValorICMS3%

		    Case "4": ; redução 17 para 11(64,71%)
                MsgBox, redução 17 para 11 `(64,71`%`) é:`n%ValorICMS4%

		    Case "5": ; redução 17 para 12(70,59%)
                MsgBox, redução 17 para 12 `(70,59`%`) é:`n%ValorICMS5%

		    Case "6": ; ICMS integral
                MsgBox, O ICMS integral é: %ValorLiqRaw%

			Default:
			    MsgBox, Opção inválida
		}
	;}
	Return
}

;=======================================================
;                        Funções
;=======================================================
CSTICMS(){
	ControlFocus, TLabeledEditText2 ; seleciona CST ICMS
	Send, +{home}20 ; substitui por 20
	Return
}
