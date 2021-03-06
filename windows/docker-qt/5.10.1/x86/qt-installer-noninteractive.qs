function Controller() {
    installer.autoRejectMessageBoxes();
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton, 3000);
    })
}

Controller.prototype.WelcomePageCallback = function() {
    gui.clickButton(buttons.NextButton, 4000);
}

Controller.prototype.CredentialsPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.IntroductionPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.TargetDirectoryPageCallback = function()
{
    gui.currentPageWidget().TargetDirectoryLineEdit.setText("C:\\Qt");
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ComponentSelectionPageCallback = function() {
    var widget = gui.currentPageWidget();

    widget.deselectAll();
    widget.selectComponent("qt.qt5.5101.win32_msvc2015");
    widget.selectComponent("qt.qt5.5101.qtwebglplugin.win32_msvc2015");
    widget.selectComponent("qt.qt5.5101.qtwebengine.win32_msvc2015");
    widget.selectComponent("qt.qt5.5101.qtvirtualkeyboard.win32_msvc2015");
    widget.selectComponent("qt.qt5.5101.qtscript.win32_msvc2015");
    widget.selectComponent("qt.qt5.5101.qtremoteobjects.win32_msvc2015");
    widget.selectComponent("qt.qt5.5101.qtpurchasing.win32_msvc2015");
    widget.selectComponent("qt.qt5.5101.qtnetworkauth.win32_msvc2015");
    widget.selectComponent("qt.qt5.5101.qtdatavis3d.win32_msvc2015");
    widget.selectComponent("qt.qt5.5101.qtcharts.win32_msvc2015");
    widget.selectComponent("qt.tools.ifw.30");
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.LicenseAgreementPageCallback = function() {
    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.StartMenuDirectoryPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ReadyForInstallationPageCallback = function()
{
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.FinishedPageCallback = function() {
var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm
if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
    checkBoxForm.launchQtCreatorCheckBox.checked = false;
}
    gui.clickButton(buttons.FinishButton);
}
