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

Controller.prototype.TargetDirectoryPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    gui.currentPageWidget().TargetDirectoryLineEdit.setText("C:\\Qt");
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ComponentSelectionPageCallback = function() {
    console.log("Step: " + gui.currentPageWidget());
    var widget = gui.currentPageWidget();

    widget.deselectAll();
    widget.selectComponent("qt.qt5.5141.win32_msvc2017");
    widget.selectComponent("qt.qt5.5141.qtwebglplugin.win32_msvc2017");
    widget.selectComponent("qt.qt5.5141.qtwebengine.win32_msvc2017");
    widget.selectComponent("qt.qt5.5141.qtvirtualkeyboard.win32_msvc2017");
    widget.selectComponent("qt.qt5.5141.qtscript.win32_msvc2017");
    widget.selectComponent("qt.qt5.5141.qtremoteobjects.win32_msvc2017");
    widget.selectComponent("qt.qt5.5141.qtpurchasing.win32_msvc2017");
    widget.selectComponent("qt.qt5.5141.qtcharts.win32_msvc2017");
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

Controller.prototype.ReadyForInstallationPageCallback = function() {
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
