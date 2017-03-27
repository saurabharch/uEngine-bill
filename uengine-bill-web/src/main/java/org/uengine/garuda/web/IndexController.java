package org.uengine.garuda.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Locale;
import java.util.Properties;

@Controller
@RequestMapping("/")
public class IndexController {

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    @Qualifier("config")
    private Properties config;

    /**
     * API 페이지로 이동한다.
     *
     * @return Model And View
     */
    @RequestMapping(value = "/rest/console", method = RequestMethod.GET)
    public ModelAndView api(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("api");
    }


    /**
     * 인덱스 페이지로 이동한다.
     *
     * @return Model And View
     */
    @RequestMapping(value = "index", method = RequestMethod.GET)
    public ModelAndView index(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("index");
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView home(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());
        return new ModelAndView("index");
    }

    //organization
    @RequestMapping(value = "organization/create", method = RequestMethod.GET)
    public ModelAndView organizationCreate(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/organization/create");
    }

    @RequestMapping(value = "product", method = RequestMethod.GET)
    public ModelAndView product(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/product/index");
    }
    @RequestMapping(value = "product/{id}/version/{version}/detail", method = RequestMethod.GET)
    public ModelAndView accountEdit(HttpSession session, @PathVariable("id") String id,@PathVariable("version") String version) {
        ModelAndView view = new ModelAndView("/product/detail");
        view.addObject("id", id);
        view.addObject("version", version);
        return view;
    }

    @RequestMapping(value = "account", method = RequestMethod.GET)
    public ModelAndView account(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/account/index");
    }

    @RequestMapping(value = "account/new", method = RequestMethod.GET)
    public ModelAndView accountNew(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/account/new");
    }

    @RequestMapping(value = "account/{id}/edit", method = RequestMethod.GET)
    public ModelAndView accountEdit(HttpSession session, @PathVariable("id") String id) {
        ModelAndView view = new ModelAndView("/account/new");
        view.addObject("id", id);
        return view;
    }

    @RequestMapping(value = "account/{id}/overview", method = RequestMethod.GET)
    public ModelAndView accountOverview(HttpSession session, @PathVariable("id") String id) {
        ModelAndView view = new ModelAndView("/account/detail");
        view.addObject("id", id);
        view.addObject("page", "overview");
        return view;
    }
    @RequestMapping(value = "account/{id}/subscriptions", method = RequestMethod.GET)
    public ModelAndView accountSubscriptions(HttpSession session, @PathVariable("id") String id) {
        ModelAndView view = new ModelAndView("/account/detail");
        view.addObject("id", id);
        view.addObject("page", "subscriptions");
        return view;
    }
    @RequestMapping(value = "account/{id}/invoices", method = RequestMethod.GET)
    public ModelAndView accountInvoices(HttpSession session, @PathVariable("id") String id) {
        ModelAndView view = new ModelAndView("/account/detail");
        view.addObject("id", id);
        view.addObject("page", "invoices");
        return view;
    }
    @RequestMapping(value = "account/{id}/invoices/{invoiceId}", method = RequestMethod.GET)
    public ModelAndView accountInvoiceDetail(HttpSession session, @PathVariable("id") String id,@PathVariable("invoiceId") String invoiceId) {
        ModelAndView view = new ModelAndView("/account/detail");
        view.addObject("id", id);
        view.addObject("page", "invoices");
        view.addObject("objectId", invoiceId);
        return view;
    }
    @RequestMapping(value = "account/{id}/payments", method = RequestMethod.GET)
    public ModelAndView accountPayments(HttpSession session, @PathVariable("id") String id) {
        ModelAndView view = new ModelAndView("/account/detail");
        view.addObject("id", id);
        view.addObject("page", "payments");
        return view;
    }
    @RequestMapping(value = "account/{id}/payments/{paymentId}", method = RequestMethod.GET)
    public ModelAndView accountPaymentDetail(HttpSession session, @PathVariable("id") String id,@PathVariable("paymentId") String paymentId) {
        ModelAndView view = new ModelAndView("/account/detail");
        view.addObject("id", id);
        view.addObject("page", "payments");
        view.addObject("objectId", paymentId);
        return view;
    }
    @RequestMapping(value = "account/{id}/timeline", method = RequestMethod.GET)
    public ModelAndView accountTimeline(HttpSession session, @PathVariable("id") String id) {
        ModelAndView view = new ModelAndView("/account/detail");
        view.addObject("id", id);
        view.addObject("page", "timeline");
        return view;
    }

    @RequestMapping(value = "subscription", method = RequestMethod.GET)
    public ModelAndView subscription(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/subscription/index");
    }

    @RequestMapping(value = "invoice", method = RequestMethod.GET)
    public ModelAndView invoice(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/invoice/index");
    }

    @RequestMapping(value = "events", method = RequestMethod.GET)
    public ModelAndView events(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/events/index");
    }

    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/report/index");
    }

    @RequestMapping(value = "apidoc", method = RequestMethod.GET)
    public ModelAndView apidoc(HttpSession session, final Locale locale) {
        return new ModelAndView("/api");
    }
    @RequestMapping(value = "clients", method = RequestMethod.GET)
    public ModelAndView clients(HttpSession session, final Locale locale) {
        return new ModelAndView("/clients");
    }


    @RequestMapping(value = "setting/organization", method = RequestMethod.GET)
    public ModelAndView organization(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/organization");
    }

    @RequestMapping(value = "setting/user", method = RequestMethod.GET)
    public ModelAndView user(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/user");
    }

    @RequestMapping(value = "setting/billing", method = RequestMethod.GET)
    public ModelAndView billing(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/billing");
    }
    @RequestMapping(value = "setting/overdue", method = RequestMethod.GET)
    public ModelAndView overdue(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/overdue");
    }
    @RequestMapping(value = "setting/retry", method = RequestMethod.GET)
    public ModelAndView retry(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/retry");
    }

    @RequestMapping(value = "setting/currency", method = RequestMethod.GET)
    public ModelAndView currencie(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/currency");
    }

    @RequestMapping(value = "setting/notification", method = RequestMethod.GET)
    public ModelAndView notification(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/notification");
    }

    @RequestMapping(value = "setting/integration", method = RequestMethod.GET)
    public ModelAndView integration(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/integration");
    }



    @RequestMapping(value = "redirect", method = RequestMethod.GET)
    public ModelAndView redirect(@RequestParam String url) {
        return new ModelAndView("redirect:" + url);
    }

    @RequestMapping(value = "go", method = RequestMethod.GET)
    public ModelAndView go(@RequestParam String url) {
        return new ModelAndView(url);
    }

}
