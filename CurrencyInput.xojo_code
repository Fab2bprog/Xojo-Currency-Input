#tag Class
Protected Class CurrencyInput
Inherits DesktopTextField
	#tag Event
		Sub FocusLost()
		  // The goal is to only allow the entry of monetary-type decimal numbers
		  Var Precision as Integer = 2
		  
		  // The purpose of this procedure is to manage the entry of numbers according to certain criteria.
		  // This procedure must be called from a text field during the LostFocus event
		  
		  Dim MyNbr as Double
		  
		  // Cleaning up spaces and tabs that could result from an unfortunate copy and paste
		  me.Text=me.Text.ReplaceAll(" ","")
		  me.Text=me.Text.ReplaceAll(chr(9),"")
		  
		  
		  // In case the field is empty and a default value has been defined
		  if me.Text.Length=0  then
		    me.Text=me.ValueDefault.ToString
		    RaiseEvent FocusLost
		    return
		  end if
		  
		  MyNbr = me.Text.CDbl
		  
		  // If the user enters more decimals than necessary, the value is rounded.
		  MyNbr = SuperRound(me.Text.CDbl,Precision)
		  
		  
		  // Case where the user has exceeded the minimum or maximum values
		  if MyNbr<ValueMin then
		    me.Text = ValueMin.ToString
		    RaiseEvent FocusLost
		    return
		  end if
		  
		  if MyNbr>ValueMax then
		    me.Text = ValueMax.ToString
		     RaiseEvent FocusLost
		    return
		  end if
		  
		  
		  //Everything that has not been forbidden is permitted
		  me.Text=MyNbr.ToString
		  RaiseEvent FocusLost
		  return
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function KeyDown(key As String) As Boolean
		  // The purpose of this procedure is to manage the entry of numbers according to certain criteria.
		  // This procedure must be called from a text field during the KeyDown event
		  
		  
		  if IsNumeric( Key ) then
		    
		    // In case you try to write a number before the minus sign the cursor is placed at the end of the TargetField
		    if me.SelectionStart=0 and me.SelectionLength=0 and me.Text.Left(1)="-"  then
		      me.SelectionStart=me.Text.Length
		    end if
		    
		    // All numbers must be entered
		    Call RaiseEvent  keyDown(key)
		    return false
		    
		  end if
		  
		  //Managing cases where the person types the decimal symbol 
		  if ( Key = SymbDecimal ) and me.Text.Contains(SymbDecimal)=false  then
		    
		    if me.Text.Length = 0 or me.SelectionLength=me.Text.Length then
		      me.Text="0"
		      me.SelectionStart=me.Text.Length
		    end if
		    
		    if me.Text= "-" then
		      me.Text="-0"
		      me.SelectionStart=me.Text.Length
		    end if
		    
		    Call RaiseEvent  keyDown(key)
		    return false
		    
		  end if
		  
		  // Allows certain keys like backspace and delete
		  if ASC( Key ) < 32 or  ASC( Key ) =127 then
		    Call RaiseEvent  keyDown(key)
		    return false
		  end if
		  
		  
		  //Management of the minus sign
		  if ASC( Key ) = 45 then
		    
		    if me.Text.Length >0 then
		      
		      if me.Text.Left(1)="-"  then
		        // Transformation of a negative number into a positive number
		        me.Text=me.Text.Right(me.Text.Length - 1 )
		      else
		        // Transformation of a positive number into a negative number
		        me.Text="-"+me.Text
		      end if
		      
		    else
		      me.text= "-"
		    end if
		    
		    // We place the cursor at the end
		    me.SelectionStart=me.Text.Length
		    
		  end if
		  
		  
		  
		  // Everything that has not been permitted is forbidden.
		  Call RaiseEvent  keyDown(key)
		  return true
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function SuperRound(nombre as double, nbrdec as Integer) As Double
		  // Procedure for rounding numbers in a better way than native xojo instructions
		  
		  Dim i as Int64
		  Dim multipli as int64
		  
		  multipli=1
		  
		  for i=1 to nbrdec
		    multipli = 10 * multipli
		  next i
		  
		  nombre = nombre * multipli
		  nombre = round(nombre)
		  nombre = nombre/multipli
		  
		  return nombre
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event FocusLost()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event keyDown(key As String) As Boolean
	#tag EndHook


	#tag Property, Flags = &h0
		ValueDefault As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		ValueMax As Double = 999999999999
	#tag EndProperty

	#tag Property, Flags = &h0
		ValueMin As Double = -999999999999
	#tag EndProperty


	#tag Constant, Name = SymbDecimal, Type = String, Dynamic = False, Default = \".", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"\x2C"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"."
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"."
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="80"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="22"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="Appearance"
			InitialValue="&hFFFFFF"
			Type="ColorGroup"
			EditorType="ColorGroup"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Format"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Password"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextColor"
			Visible=true
			Group="Appearance"
			InitialValue="&h000000"
			Type="ColorGroup"
			EditorType="ColorGroup"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hint"
			Visible=true
			Group="Initial State"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Text"
			Visible=true
			Group="Initial State"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextAlignment"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="TextAlignments"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Left"
				"2 - Center"
				"3 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowSpellChecking"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaximumCharactersAllowed"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValidationMask"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReadOnly"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValueMin"
			Visible=false
			Group="Behavior"
			InitialValue="-999999999999"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValueMax"
			Visible=false
			Group="Behavior"
			InitialValue="999999999999"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValueDefault"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
