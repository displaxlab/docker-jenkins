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
    widget.selectComponent("qt.qt5.5120.win64_msvc2017_64");
    widget.selectComponent("qt.qt5.5120.qtwebglplugin.win64_msvc2017_64");
    widget.selectComponent("qt.qt5.5120.qtwebengine.win64_msvc2017_64");
    widget.selectComponent("qt.qt5.5120.qtvirtualkeyboard.win64_msvc2017_64");
    widget.selectComponent("qt.qt5.5120.qtscript.win64_msvc2017_64");
    widget.selectComponent("qt.qt5.5120.qtremoteobjects.win64_msvc2017_64");
    widget.selectComponent("qt.qt5.5120.qtpurchasing.win64_msvc2017_64");
    widget.selectComponent("qt.qt5.5120.qtcharts.win64_msvc2017_64");
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
