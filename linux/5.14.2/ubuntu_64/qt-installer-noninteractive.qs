function Controller() {
    installer.autoRejectMessageBoxes();
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton, 3000);
    })
}

Controller.prototype.WelcomePageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    gui.clickButton(buttons.NextButton, 4000);
}

Controller.prototype.CredentialsPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    var page = gui.pageWidgetByObjectName("CredentialsPage");
    page.loginWidget.EmailLineEdit.setText("dpxskinlab@gmail.com");
    page.loginWidget.PasswordLineEdit.setText("Dpxis1357!");
    gui.clickButton(buttons.NextButton, 2000);
}

Controller.prototype.ObligationsPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    var page = gui.pageWidgetByObjectName("ObligationsPage");
    page.obligationsAgreement.setChecked(true);
    page.completeChanged();
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.DynamicTelemetryPluginFormCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    var widget = gui.currentPageWidget();
    widget.TelemetryPluginForm.statisticGroupBox.disableStatisticRadioButton.checked = true;
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.IntroductionPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.TargetDirectoryPageCallback = function()
{
    gui.currentPageWidget().TargetDirectoryLineEdit.setText("/home/jenkins/Qt");
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ComponentSelectionPageCallback = function() {
    var widget = gui.currentPageWidget();

    widget.deselectAll();
    widget.selectComponent("qt.qt5.5142.gcc_64");
    widget.selectComponent("qt.qt5.5142.qtcharts.gcc_64");
    widget.selectComponent("qt.qt5.5142.qtpurchasing.gcc_64");
    widget.selectComponent("qt.qt5.5142.qtremoteobjects.gcc_64");
    widget.selectComponent("qt.qt5.5142.qtvirtualkeyboard.gcc_64");
    widget.selectComponent("qt.qt5.5142.qtwebengine.gcc_64");
    widget.selectComponent("qt.qt5.5142.qtwebglplugin.gcc_64");
    widget.selectComponent("qt.qt5.5142.qtscript.gcc_64");
    widget.selectComponent("qt.extras.qtwebview.qt55.gcc_64");
    widget.selectComponent("qt.tools.ifw.32");
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.LicenseAgreementPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.StartMenuDirectoryPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ReadyForInstallationPageCallback = function()
{
    console.log("Step: " + gui.currentPageWidget());
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.FinishedPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm
    if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
        checkBoxForm.launchQtCreatorCheckBox.checked = false;
    }
    gui.clickButton(buttons.FinishButton);
}